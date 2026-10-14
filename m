Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A241CC6B1D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 02:26:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGogf-00011o-K1; Tue, 13 Oct 2026 22:25:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haoqian.he@smartx.com>)
 id 1xGogd-00011C-5U
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 22:25:47 -0400
Received: from mail-dl1-x122d.google.com ([2607:f8b0:4864:20::122d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <haoqian.he@smartx.com>)
 id 1xGoga-0003sl-Rl
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 22:25:46 -0400
Received: by mail-dl1-x122d.google.com with SMTP id
 a92af1059eb24-17bc533fda3so502824c88.1
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 19:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20251104.gappssmtp.com; s=20251104; t=1791944742; x=1792549542;
 darn=nongnu.org; 
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=/houb6mkklFNG2/ZINMcSxl2XD4a/A9BaEpIfuGs+fM=;
 b=Ze8vtmugAuVEoMQi9KdDgb5W/onXy8WAC8SbvWb0H5xyZnCt2k5/xcDfBEftFC6ZzS
 FyUJtkDlS5sO3KAXUh8664xi8arwmuFx7RaC+2EUSmgJqtFUW6gkEbYxgq3kobLjoBhq
 lRjIUqUgcMP1K0GCHJrKeB57x95+u4Pn+lryqk7nF6q4Zyge6j9BQX6VzzJyQdr3Wlax
 snZxFknqV+pFmQUl6DqT8Ug5QfVnW3fAy7k14oVEFXbeRGGbqtQQoa9tiOVmjVcfE1jk
 4xJ1Lq3jNa1Ykd0dBeNJkiJMd0jfRwoTQbhNtlngXQ8/3+gDqQ0ke2dzTS1l9hMhrmu/
 IS7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791944742; x=1792549542;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/houb6mkklFNG2/ZINMcSxl2XD4a/A9BaEpIfuGs+fM=;
 b=m/V5Yn7IK4qzzQH1REQoLBrhd5rdQoGQ1wcKvmkR64aUcyFV52oKdL9qzHPPMGYbwz
 trl3gtip+4NUSOAHHibPq7BpxkbmVLr8QJ7vVXLolY5NNZI65OC6uNelWtEz+Zjxb7Kh
 m6mp1OENwijVafsIlo2u16/z1kgCcten/fvzSVqDRutNgIzcT/ZPQkWKrqtwCTQ39L6v
 slgpPVWp2427zreq/rkRjXHB5Jjlh8rdNnpqQhXhQ1aYL8Zlebs/NRoeJshtegs9PuQm
 EV32OJmgvCnTFxhvEoYRM724++LzN4JA/ObBmxpSMcPz9HwQ7n8b3EuMNzO3w1l08QHS
 tjbg==
X-Forwarded-Encrypted: i=1;
 AKwUvByM7/5/Oy/F/fMKLm00e6faG9XjdNI3kb2zuZXWYlKpRWXrPGU6TZUmY4f05tIuXQuYnonyqY2NGNyZ@nongnu.org
X-Gm-Message-State: AFq9FYI8cWfh3hf87/FaTekjYbNChogv6sx00m5Ju9TdmQRX8YBXnG1E
 HwIICyX3Li82TrDmpGGb4Kfjab3O94JsH3/eWFWKvXbgYDbsNNXSbucOvBwKJKRfEbQMqLwla8G
 O6HL3/xZ8ObRWlKYMODdkfPZlkWHXtXS70g5knX16gX7/j0grFg==
X-Gm-Gg: AYBFou0DSPuDbPVLM9UWnk63qsYmN2OsRo617Dukk+q3LAWoxBIGDxqGK9ulyWD6qjm
 lM2/aGkROEepohpnbJPNYQ6rNy5CKn6oZ2YE8GFWZNS3fhEDvqYyRkNjKfZniFtppwijNru2MUR
 va5SwatrqLScgPUoFrxWUB5PnxzR0JjrwQoJHQHRTiK+0+I3Pe3mNzv1CigXg2rRsvFfL3Ttm60
 sEzlIiQaRTGzadNdYCR4S3PA5iOPfae2l8mriZL+c6Sj7BY6Qn4BVy137r8PORPee6ioGO9zmHV
 IwWZO8IaA6tY+tZEtEhrN7ywtvVzLfE/rrj9QA4GzSoJVlzx4/HXer81Yu3DRQVz7xrvo578lGt
 Tm7qZk7fgrsX0KkHPND/t1e0ywVXBeFOYjxeO0T7Rd8S+JD5I2J73pmWqXGQb5hEdfsiDC575sz
 Oh05np6aIcGCXxTMj1fCMxf5+4sPobmFhM1kC3pvHf4KKRwaFDUfYKJLU0UJ9ZpuJm5OpovcJDB
 WzyKWHP12ywLFtmGg==
X-Received: by 2002:a05:701b:2605:b0:144:fa57:c617 with SMTP id
 a92af1059eb24-16a60a02625mr21230459c88.34.1791944741923; 
 Tue, 13 Oct 2026 19:25:41 -0700 (PDT)
Received: from smtpclient.apple ([174.136.204.24])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a1dd57d0sm42549574c88.8.2026.10.13.19.25.39
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 13 Oct 2026 19:25:41 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.500.231\))
Subject: Re: [PATCH] block/mirror: inherit the source node discard flag in
 mirror_top
From: Haoqian He <haoqian.he@smartx.com>
In-Reply-To: <as43zG5OHroMfIJZ@redhat.com>
Date: Wed, 14 Oct 2026 10:25:26 +0800
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-devel@nongnu.org, fengli@smartx.com, John Snow <jsnow@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <0D7D0521-3629-4257-B92C-3EF31509E584@smartx.com>
References: <20261013060549.3008438-1-haoqian.he@smartx.com>
 <801bb56f-c704-4649-9938-73e9370d7a08@yandex-team.ru>
 <as43zG5OHroMfIJZ@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
X-Mailer: Apple Mail (2.3731.500.231)
Received-SPF: pass client-ip=2607:f8b0:4864:20::122d;
 envelope-from=haoqian.he@smartx.com; helo=mail-dl1-x122d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



> 2026=E5=B9=B410=E6=9C=8813=E6=97=A5 21:53=EF=BC=8CKevin Wolf =
<kwolf@redhat.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Am 13.10.2026 um 10:15 hat Vladimir Sementsov-Ogievskiy geschrieben:
>> On 13.10.26 09:05, Haoqian He wrote:
>>> mirror_start_job() inserts a mirror_top filter above the source node
>>> for both mirror and active commit jobs. Previously, the filter was
>>> opened with BDRV_O_RDWR only, even when the source had BDRV_O_UNMAP
>>> enabled.
>>>=20
>>> The block layer checks BDRV_O_UNMAP before invoking a node's discard
>>> callback. Without this flag on mirror_top, discard requests return
>>> success without reaching bdrv_mirror_top_pdiscard(). Consequently,
>>> starting a job can silently suppress guest UNMAP/TRIM requests that
>>> would otherwise reach the discard-enabled source.
>>>=20
>>> Initialize the filter's open flags with BDRV_O_RDWR and =
conditionally
>>> add BDRV_O_UNMAP from bs->open_flags. Pass the resulting flags to
>>> bdrv_new_open_driver() so that mirror_top follows the source node's
>>> discard setting.
>>>=20
>>> This allows discard requests to reach the existing filter callback,
>>> which forwards them to the source and either tracks the affected
>>> range in the dirty bitmap or synchronously propagates the discard
>>> to the target, depending on the copy mode.
>>>=20
>>> Signed-off-by: Haoqian He <haoqian.he@smartx.com>
>>> ---
>>>  block/mirror.c | 10 ++++++++--
>>>  1 file changed, 8 insertions(+), 2 deletions(-)
>>>=20
>>> diff --git a/block/mirror.c b/block/mirror.c
>>> index 089856f4a8..a551d392c6 100644
>>> --- a/block/mirror.c
>>> +++ b/block/mirror.c
>>> @@ -1854,6 +1854,7 @@ static BlockJob *mirror_start_job(
>>>      BlockDriverState *mirror_top_bs;
>>>      bool target_is_backing;
>>>      uint64_t target_perms, target_shared_perms;
>>> +    int flags;
>>>      int ret;
>>>      GLOBAL_STATE_CODE();
>>> @@ -1886,8 +1887,13 @@ static BlockJob *mirror_start_job(
>>>      /* In the case of active commit, add dummy driver to provide =
consistent
>>>       * reads on the top, while disabling it in the intermediate =
nodes, and make
>>>       * the backing chain writable. */
>>> -    mirror_top_bs =3D bdrv_new_open_driver(&bdrv_mirror_top, =
filter_node_name,
>>> -                                         BDRV_O_RDWR, errp);
>>> +    flags =3D BDRV_O_RDWR;
>>> +    if (bs->open_flags & BDRV_O_UNMAP) {
>>> +        flags |=3D BDRV_O_UNMAP;
>>> +    }
>>> +    mirror_top_bs =3D bdrv_new_open_driver(&bdrv_mirror_top,
>>> +                                         filter_node_name,
>>> +                                         flags, errp);
>>>      if (mirror_top_bs =3D=3D NULL) {
>>>          return NULL;
>>>      }
>>=20
>> Cool find!
>>=20
>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>>=20
>> Thanks for fixing, applied to my block branch.
>=20
> This bug is something that should be relatively easily testable in
> qemu-iotests. Can we please add a test at the same time?
>=20
> Kevin
>=20

Okay, i will add qemu-iotests in the subsequent patch ASAP.

Haoqian


