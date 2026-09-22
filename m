Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7708FC98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 19:23:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x964D-0000eq-NV; Tue, 22 Sep 2026 15:22:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x963g-0000YZ-UX
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 15:21:42 -0400
Received: from mail-oo2-x2b.google.com ([2607:f8b0:4864:31::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x963f-0002P6-8l
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 15:21:40 -0400
Received: by mail-oo2-x2b.google.com with SMTP id
 006d021491bc7-6c2613d80fbso133568eaf.1
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 12:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1790104898; x=1790709698;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=70b7LD7uwTl7YbiqcFI5FWkVSxRT4jcT0BQnJC/Dt4o=;
 b=dT8N03C95o4BcTjJPYyQ1kHMlML19anUS6GYdULpfoau6/B+R6q7ZYv6ryDmlra9KV
 iy09z6Zzb7AKEB6uYXfh98PScp9yZPNTK3lkJ7uk99UVDaU+PC8RhvuwPsEivlGANNOv
 Dgq3r0nJhEPWD9NPHEVGtBXUienQ8EK/Kd2bfBcYkWOPIYJ2VQ/N3iO6T07VoSfbwSqe
 466kpiTCWhhB634yLDzVSbX7E51qNihMLFtuBEVfrpa4rvrOCkT5hbu8kzoz4PN8seRv
 qqisH5tu9X5xs2fR+0JDw9yzpnne6OIdeOEXGvT3Ko3Pj7ofLAMkOBLU9vm86VQTBRIJ
 xkWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790104898; x=1790709698;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=70b7LD7uwTl7YbiqcFI5FWkVSxRT4jcT0BQnJC/Dt4o=;
 b=UU5Aom0HWXy8xx1SG1Y5JV5y9CVP79oX+dYGQcoJSusZVxbUzwgA+cKf8v5JkIAV3z
 v37i4fmco4nRs6wEPQmaRL2FfwfyXr88NTRz+bZERUveyALCqV+4cjzJgdqAASK3jUI5
 QhuLSoO8Wh8GIG75/+Ff7XmijDoS4e/KxLEp0XmcmJkDRicdEsxRtJ2LyJ63yrigBpVs
 UJCrc9gR123JDStWOlISj3T2NItqwb2bChJ0CAtoJEAn+8hmTQV8tQ6DGYoAli9czTDS
 dHV1CcSHsR2i/4P6z5oucbTCKYorS5Fj7vrTnMaVLXzN4Y6SRRubqVTH+HFHE40LvkBY
 V9Cg==
X-Gm-Message-State: AFuF++ltOLcCllS2JI/GX4A8/R9s838UwPEUMjPZOLGaxuAUTc1RyeYh
 obrBGA2X06l+svo7Y3Ck5fr3dVlftnwZS1vv7opi+MdXglWhPw4RiEPMhIQpTx0GmWsQKHOJMe+
 KeMbj8yE=
X-Gm-Gg: AYBFou2y65SlPBCX3juyXJtHOIyRW97bfdOfukfSOnsn1z4xqxbfM6gd6c89HVv/rAx
 IfMpsCc7qw0h8r1sWBHOBB2JAFiU7A3KwSZnYQHh8AVDeKLKrDdoQu+cfWK7wCyHYieV9D7Dzlm
 pAlan/gybTRThJE0l7hvQOsBH/0tRt/jPwwaDlp7qEGqRAckGO0uTypfMXzMFZY36n+eSSHUT48
 /b9IYyAPpRjmMf1t9zHS/kGJhm4TbwxTgAZ9C85WSE8i8dhldAKUUH+aExTlanpnpvHNlJDUK2o
 tSbKWx2tBknh/kR7jfliojHp+AVQo1wKq1Rgyu/EViIBBgVG0xCKrg2/RCENHk7UMRLi/0dvEnr
 8RQgbwdwYYSfJoJKyQVKt08Xw/A03mYe6YLnEBzIUbCDQi7BYu67EztibRwOFxj9MZJly4pYi2i
 N9W0wBFzwhjBQB6qGRkBt4SnP6zKuIjPMOGz/60lIle/ElxepgvQfBOGTINeNMFr63b/gK
X-Received: by 2002:a05:6820:4c0d:b0:6cd:3ffc:e32b with SMTP id
 006d021491bc7-6d2d261ca81mr352293eaf.73.1790104898092; 
 Tue, 22 Sep 2026 12:21:38 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6d2ce763f72sm646776eaf.7.2026.09.22.12.21.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 12:21:37 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 10/11] bsd-user: #ifdef sockopt that aren't in 14
Date: Tue, 22 Sep 2026 13:21:08 -0600
Message-ID: <20260922192109.98467-11-imp@bsdimp.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922192109.98467-1-imp@bsdimp.com>
References: <20260922192109.98467-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:31::2b;
 envelope-from=imp@bsdimp.com; helo=mail-oo2-x2b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-sockopt.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/bsd-user/freebsd/os-sockopt.h b/bsd-user/freebsd/os-sockopt.h
index 2f984cf8e3..55b678824d 100644
--- a/bsd-user/freebsd/os-sockopt.h
+++ b/bsd-user/freebsd/os-sockopt.h
@@ -281,6 +281,7 @@ static struct sockopt_entry ipproto_tcp[] = {
         { IPPROTO_TCP , TCP_RACK_PACE_MIN_SEG, { SOCKOPT_TYPE_INT, } },
         { IPPROTO_TCP , TCP_RACK_DGP_IN_REC , { SOCKOPT_TYPE_INT, } },
         { IPPROTO_TCP , TCP_PACING_DND      , { SOCKOPT_TYPE_INT, } },
+#ifdef TCP_SS_EEXIT
         { IPPROTO_TCP , TCP_SS_EEXIT        , { SOCKOPT_TYPE_INT, } },
         { IPPROTO_TCP , TCP_DGP_UPPER_BOUNDS, { SOCKOPT_TYPE_INT, } },
         { IPPROTO_TCP , TCP_NO_TIMELY       , { SOCKOPT_TYPE_INT, } },
@@ -289,6 +290,7 @@ static struct sockopt_entry ipproto_tcp[] = {
         { IPPROTO_TCP , TCP_SIDECHAN_DIS    , { SOCKOPT_TYPE_INT, } },
         { IPPROTO_TCP , TCP_FILLCW_RATE_CAP , { SOCKOPT_TYPE_INT, } },
         { IPPROTO_TCP , TCP_GP_USE_LTBW     , { SOCKOPT_TYPE_INT, } },
+#endif
         { SOCK_LEVEL_NONE }
 };
 
-- 
2.55.0


