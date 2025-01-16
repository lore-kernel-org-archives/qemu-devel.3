Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BC0CC02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 16:14:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYSUs-0005zU-R1; Thu, 16 Jan 2025 11:13:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYSTp-0003jn-3G
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 11:12:31 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYSTh-0004VO-MM
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 11:12:24 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-385deda28b3so793059f8f.0
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 08:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737043936; x=1737648736; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rem+PqKJwtTryCp5+P2h89dN9I6AHO+TdjB2QsczI6k=;
 b=ORIAvb7QS//IvRNHnCvpPlFBhmH8dXPuHCaAlKjPGqblY7jJU3FM0NZWpKCEHk+uUD
 wjjCdTkAB0LRCjkq07ue0uW/rS03TCgFf+AIApkX/fAZU/ssdWKM98lYq4nsSnlPdCdl
 /I968RP+Y2nEMpSps8fyBE/KQvHHIomYmw3basSqMH3xdr0ladtfcU61uOyyacIbrQ8h
 8qE0kb9gHesLP2ILU+sNS9EYyQN+BGrT25k2lai95AmiUC3jcXQkZaXMwIbUcebbWeFr
 otsSqFsWrQrF/0AbDyctzmlwqffh/NinoK58mqTXqjPFTPQxOs0vhmSbKykXm3LyfUxw
 4vkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737043936; x=1737648736;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rem+PqKJwtTryCp5+P2h89dN9I6AHO+TdjB2QsczI6k=;
 b=PfInQrKRVv8zfufOH8ds3sK/oykk2QPPNiFRdjYQ9ovrkAmVcPEy0R+FxiZhtuq5g5
 WjkrTJBwmG5jVJ/cIcdY3O1Z8ZPCGzUgOf2BW2aT8giY4yaw8xKmzP3fD6GacIBIztFi
 tVbPJRn5bb+/NU4unGhH20f5pwBPhErmZMBRGCAecu0Qe4xRVbJHlgZD8g1YHjNWWfIF
 7HHSJ2/t05JkfHnyjruZtMsFb6rJqMQEqHMFf/hRnfywjjQhUEY4DfwSkv7OXYI3yOcE
 /U9CAMhyRZuUS1dLtNNzBF0b54wJHQusym/Nq18ToOKLcyfzlB8bRxcIzCfF9TARCkpl
 gU1Q==
X-Gm-Message-State: AOJu0YzPtAAOOvHMuThGpdNngymBwZEY5PnziRvyIYT1LIYr4pIsr691
 uFTDED8mOyTMSBKrfYWVfctjkolYSRmIxtRT4KOYQMALGNPyWIRKv8S2GGaISEc=
X-Gm-Gg: ASbGnct/BodzG0MAwlZ462JzicgRLwzb8vTCHzTkg9ZuUc7risdXtIUj6N4FQfC3H3r
 LXOGyo0dkhwa0ZmoL4Wig+X3B46mfY8YdnwfuBJ0V3sZObmrGPmFnzkRjAP3oKb3xRveUd83eyH
 TM15GZtx3uHvjxC+2w79GspFEtHrAww1OYsTMa6B8Hhku0fE7Vo/PkSDhw9yF60k13rzmIPS9y1
 1VJeuzMSSVR3w0/BNHvDnMvbID2+aquW1I/vN2LvYZKEnIOQUFNJuo=
X-Google-Smtp-Source: AGHT+IH1oaiWeTG7A0vPv1ZV2Zuj12j1DFv/33UgDSQzbLF+G1WhcrjDtjyogZBoxU10RC2co3yMdw==
X-Received: by 2002:a5d:5886:0:b0:386:4312:53ec with SMTP id
 ffacd0b85a97d-38a873049c2mr28737544f8f.17.1737043935929; 
 Thu, 16 Jan 2025 08:12:15 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf3275755sm217697f8f.80.2025.01.16.08.12.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 08:12:15 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B131360812;
 Thu, 16 Jan 2025 16:03:09 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Jason Wang <jasowang@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Weil <sw@weilnetz.de>, Stefano Garzarella <sgarzare@redhat.com>,
 qemu-arm@nongnu.org, Michael Roth <michael.roth@amd.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, David Hildenbrand <david@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Alexandre Iooss <erdnaxe@crans.org>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 33/37] docs/devel: add b4 for patch retrieval
Date: Thu, 16 Jan 2025 16:03:02 +0000
Message-Id: <20250116160306.1709518-34-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250116160306.1709518-1-alex.bennee@linaro.org>
References: <20250116160306.1709518-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20241209183104.365796-4-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/devel/submitting-a-patch.rst | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/docs/devel/submitting-a-patch.rst b/docs/devel/submitting-a-patch.rst
index 69df7682c5..65c64078cb 100644
--- a/docs/devel/submitting-a-patch.rst
+++ b/docs/devel/submitting-a-patch.rst
@@ -433,6 +433,20 @@ For more details on how QEMU's stable process works, refer to the
 
 .. _participating_in_code_review:
 
+Retrieve an existing series
+---------------------------
+
+If you want to apply an existing series on top of your tree, you can simply use
+`b4 <https://github.com/mricon/b4>`__.
+
+::
+
+    b4 shazam $msg-id
+
+The message id is related to the patch series that has been sent to the mailing
+list. You need to retrieve the "Message-Id:" header from one of the patches. Any
+of them can be used and b4 will apply the whole series.
+
 Participating in Code Review
 ----------------------------
 
-- 
2.39.5


