Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F308ACD8C9D
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 14:24:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWat7-0005Yk-Gs; Mon, 08 Jun 2026 10:23:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wWat5-0005Xx-5F
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 10:23:35 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wWat3-00054r-GT
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 10:23:34 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-6870ad8072eso8652531a12.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 07:23:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780928611; cv=none;
 d=google.com; s=arc-20240605;
 b=NKRTLgPS6x78qQM9S7fQsSi9PlPGv6zd3ARp6ZGUrhAjElrmQIOZdsqt5LO4ObC8zK
 3Cz/jHs9g5Q2bd2kY3uwukw4oyEw/9qcZMsUvYnL3OFxt2vIf5iVsB6DpN6c3x9RxuZE
 o1CmHXOfnQBP8Vj5DmbGma/vpG39VZ8PqiyBplzHHUqhFWQlBGxiPBORHopQmnRDvRNL
 nxNfMNb89SyybZRHwAI/tD2shSQhz/uOSAJ8WKydkLoAvoylWA9bFxE4CbLVS9hKl31m
 +qPt6akBTawHk1t3IzrkiA8W2F9iPIxcVmsISqEd2uD4HUy0mFpctBFbiLmsgujfsdgN
 bPgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=4QsyEM9uDe2Br8LgxO1rHPCS2z0VQDI013Eq/lLKIqg=;
 fh=+Z3OB2pV/fM4y3pvVR7ygymZkRHNk0PIG0kh21i1CmA=;
 b=X517Z+eRs/EwX6lmWRgZFtWHRxabnBIOn3VHSWnQi3wXsr8uIwYoOo4yEivK8Wr6S4
 3ff1ScojVe9C3M5LQGKzh/PpvdL4gty4h88HdpIcrDkQh6Oy9Y+abIQO9lwHxVpwr2nj
 I4K0lFs1fI58IJKZamz81+rcqEIrmAeSeZXrQgmcHT0FpaeLaHgPNXF5lV2TZvFZxZhs
 GgQT7cKE82/qsBCwaxYc//YslwdKMV2bLR0Og30H1aToZbmECMOaf3lM33aRc37hAzIm
 NL+jldytBfKbnLbUSK7/Tuo0AGuBMXJBrtFFBhlfANPYghplHYjY1C3WwFZ1yrKIoGbD
 Jn/g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780928611; x=1781533411; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=4QsyEM9uDe2Br8LgxO1rHPCS2z0VQDI013Eq/lLKIqg=;
 b=FY+z32/DnbfIM2buakYJ5qjGugoZJxMeqZI3k6fitmKntkw1UzvmNkDt+JM85dkSqp
 aMQxiJuwhSCgYzk9GsDYbZ/yIA2tjLcs2YvVH7QroEeJu8ORXjmeSOAD73izaw9KeF8m
 LrcQczN+dgioYD9QKk6TMdzdd8u4aDgoJZyXs7AM37L03giGJttCKjWlMvp061l9oMcO
 PP7NhdkxU7WzPO8VIekiCXaNu88Wu3rQqpFERQCxrRU5ZrXh9duvdSm5gBaM9gfsJPAA
 B0Dy9Au4hfmT+JL43NDeiDHihA8DrRKP3SZnhZfjqeiPbPQW/iT/OKPgeMstOW1vWI1N
 SueQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780928611; x=1781533411;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4QsyEM9uDe2Br8LgxO1rHPCS2z0VQDI013Eq/lLKIqg=;
 b=gL51IWtV1PAI2Uoo4Qci7IW6PyRsr6J36/hNEITtUd+tS71Q3KYIclOHwX/RBKlyjd
 3DXjafYMWsgchnQFyRLjNBpFHS/x1ws2p2hXRWTFzBN/eVj1Xd3zsmKJF6zJD29d+G+q
 c0wLgU8KwoN71cJr8glygKeOqjz2w46HaT6X1GRzGJmg1GegKRE8pp2AVavxb4Qy/51e
 B7b/S7Z5EJvyjTKVlasV28JHCrpyJuZCn2bKZ6WX5lrW0YTafEL1tFiQMDnVb6N6l7oc
 xE0PwG0LYdkjDIrO4FDdoy+TTnUx+lgL7S13kdLGdv50h3umhwcyNv5JnyGfd284vVe6
 +FDw==
X-Gm-Message-State: AOJu0YwKwWWFKyYE0FSxQ+oP1RPLIGjDw3xqQ/s/YpL1nwmCEme8zw5O
 ESWgt0ZtI7jEXJ00jVt/zjG35hv+D6n9hD+5IzTB4cUqxuRBFAAZdXzci9vXm5V+cSbb/E3Z5fv
 nhEHTPn/OjTS8oBnr9SmtOs/HOsk56aM=
X-Gm-Gg: Acq92OGjvsN1WZM8AzS8z5qTA07ou1BvL/c6YpyH4Ne1ES4a1kArrRDVEAwDORAVNXo
 5UvXA7o8z5I2jVJ6ap0kKgvg6p+Xi4kTw6+VVW/VP50zDEhireyalVzK7UkBDbld0jW3icPRuDL
 8inejb9f+U7PGqba4bcrVop59AmLXzqdEkq015ie916uA8ctYbPUDUQzpZijCeFO89ADGrx0/yl
 mz6xgJQnPQ35jy+Q2sEZbjrs1r9SkphLiAC2Ii2f99iv9jpblFWJNAB4bKRWaCEOLYg2hPe0CNQ
 IoQpj1WGkHvnWaNmiMKNqTufiui5eyURQaYpoCZCRhoCPZXdCj0s
X-Received: by 2002:a05:6402:52cb:b0:67c:34bb:1bd1 with SMTP id
 4fb4d7f45d1cf-68ff1930602mr4915316a12.1.1780928610810; Mon, 08 Jun 2026
 07:23:30 -0700 (PDT)
MIME-Version: 1.0
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 8 Jun 2026 10:23:18 -0400
X-Gm-Features: AVVi8CdN60YWrHfj4iaj3b1ObW22VmayDFq3_FtwDye8VfNLgqICMQQLdsI23A0
Message-ID: <CAJSP0QU6Ko87bYaaNm6DCB7krVZgbo_YohuVKSAunBpnDJFdHA@mail.gmail.com>
Subject: Race condition in qemu-iotests nbd 205?
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>, qemu block <qemu-block@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Vladimir,
It looks like there is a race condition in qemu-iotests 205 when the
NBD server is shutting down:

+FAIL: test_remove_during_connect_safe_hard (__main__.TestNbdServerRemove)
+----------------------------------------------------------------------
+Traceback (most recent call last):
+ File "/builds/qemu-project/qemu/tests/qemu-iotests/205", line 149,
in test_remove_during_connect_safe_hard
+ self.assertExportNotFound('exp')
+ File "/builds/qemu-project/qemu/tests/qemu-iotests/205", line 63, in
assertExportNotFound
+ self.assert_qmp(result, 'error/desc', "Export 'exp' is not found")
+ File "/builds/qemu-project/qemu/tests/qemu-iotests/iotests.py", line
1246, in assert_qmp
+ self.assertEqual(result, value,
+AssertionError: "Export 'exp' is already shutting down" != "Export
'exp' is not found"
+- Export 'exp' is already shutting down
++ Export 'exp' is not found
+ : "error/desc" is "Export 'exp' is already shutting down", expected
"Export 'exp' is not found"

https://gitlab.com/qemu-project/qemu/-/jobs/14745043965#L328

I have not seen this CI failure before, so it might be rare and hard
to reproduce.

Stefan

