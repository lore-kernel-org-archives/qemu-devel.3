Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7400DC624D3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 12:55:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2TQI-0001eh-6u; Fri, 04 Sep 2026 08:53:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TQF-0001d1-V1
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:53:35 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TQD-0000gW-8K
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:53:35 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-4843e9c5960so984704f8f.0
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 05:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788526412; x=1789131212; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gO810BRB2c4AHIUTMhtMi2JLuKUFaJ3pQjqUbrBLEto=;
 b=AdJgdsO9LAUeRojAgF099PbKYB6SkulWUXhQekszRe33ep2QjZVE8j0pCU+09Qrrv1
 oY9VoOghZ1OX9EMntkU56ERCkQuB6mamfp7a7wNliznVfIkM/2kYa3+YTNIOp7eX6F3H
 gHMU84JKnTvdNBSwe3H5uTAfFurAIp2pSTd1PLvMDeZyKIXj902D+n8psA1+2JVJBuOa
 HOIEJUo+xSJYbFR6vp7muslOb6F8ER9aAN+zcSYa2PHM94se2IkypiEwCvKajlFDVziY
 WwP9xL9Svidy70bBDWpTnbeDg3iQOsKN6Ujyywh8B7bP5yxc3qeg3WAoivdt+ygVXM48
 o8og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788526412; x=1789131212;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gO810BRB2c4AHIUTMhtMi2JLuKUFaJ3pQjqUbrBLEto=;
 b=XFz4iESlts82v/epApiBwnHbgYE1oeJf5xuj5GuOds1TeWR11gKNfffON7wC18PsRm
 6YyYk+6La8f7Y0qx87jZK1XVf0F8lMQjCM+fzOqM+m252h5s3SxczLXf9/URZuR3hyQL
 cPkEDjKn6H2btbLgOrqVmkGD+PT6D2XwpzT3iMNArW0Mwj6rI5qHFiiFaXQciON+87Wn
 CClyM6CeGjc2c90lyS8i8+yMH+Vja8j53kaGJter3QvsWHwi0Wc0Xw/IgO6WWuYbSgAh
 LumvDqskOdna5UxtmC+/bp/D2QZ+Ha9Da4fjDTJ4iHmUPJ5H473m3j3/+KbIsrEbeBGD
 IjZg==
X-Gm-Message-State: AFuF++mngejMEm8gHTQNXhV/D9Klu9sFHDDTL0jbwD7qj7umM0Ls/GC6
 Ueaa6rr2Yca5UuqJd6ZQfiOLZQVYzgKc+YWn176AU/FSzudFZPjgf5LuMMGq8ztJDes=
X-Gm-Gg: AYBFou3lUeyC7zub63HFXMZF/W5Fo5P5ax9iVjP247ppfklQS1G/EWfnr5pFbQPh94+
 Z9kZ59ZPLT5WNt9ezqNQSW/XIkzvaLneEqlp8P6KYmHraxq+ybR9tH7ZYt6URzvLtFD+9n5YGju
 /FBjvxKUGAoyEwq6y20qAbo0P7pA35FSeZxpNf7in98udp6yHSv5NOpZpoBiiuUq3Aqt1fcnpB1
 Yba+lhPHVcgubuoXgc4K5ajLAQutmf2t0vun47rb0NF4dxSVUV3W6qyIWbiXakm0e80VL59qzba
 QLAvAf/FuzzHgoKrJt/14uC7PypMLxSO3258XPKtiIHbn+aVb1rMMLnfVgMlxUuCoUPN0qzi9Bc
 o+g8tIfkTwZfvVSrpotKAZyzcoFlRgoFT4nWgyjkDV3bZK09AX9QXWT4T3Dq8d1Sp8+V5nuZWH6
 CB/QiNwW/OIuV1ZwcrktIENz3Gp+Td60vTur4ZueGOJykmTOHSDDZtVUmjBKOf
X-Received: by 2002:a05:600c:19d1:b0:49c:fc6e:8cbb with SMTP id
 5b1f17b1804b1-49cfc6e8e05mr35181575e9.31.1788526411857; 
 Fri, 04 Sep 2026 05:53:31 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce58da3acsm399360135e9.0.2026.09.04.05.53.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 05:53:31 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1AD7161D5E;
 Fri, 04 Sep 2026 13:46:13 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aniket Sahu <asahu1x@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 qemu-s390x@nongnu.org (open list:S390 TCG CPUs)
Subject: [PULL 082/105] tests/tcg/s390x/head64.S: declare _exit symbol after
 main
Date: Fri,  4 Sep 2026 13:45:36 +0100
Message-ID: <20260904124604.2207440-83-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904124604.2207440-1-alex.bennee@linaro.org>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

tests/tcg/multiarch/gdbstub/registers.py expects to find this symbol to
compare state of registers before and after execution. Define it
explicitly.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260827221506.91574-83-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/tcg/s390x/head64.S b/tests/tcg/s390x/head64.S
index 4fe288388ab..0523fcacb33 100644
--- a/tests/tcg/s390x/head64.S
+++ b/tests/tcg/s390x/head64.S
@@ -14,6 +14,8 @@ main_pre:
     aghi %r15,-160                     /* reserve stack for C code */
     brasl %r14,sclp_setup
     brasl %r14,main
+.global _exit
+_exit:
     larl %r1,success_psw               /* check main() return code */
     ltgr %r2,%r2
     je 0f
-- 
2.47.3


