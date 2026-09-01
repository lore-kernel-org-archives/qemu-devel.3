Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B7B0C61DD3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 13:33:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1ObI-0007ZH-K7; Tue, 01 Sep 2026 09:32:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x1ObF-0007Z0-Kr
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:32:29 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x1ObD-0002Ml-8b
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:32:29 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-495437bb891so8452635e9.1
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 06:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788269545; x=1788874345; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=iri/uHhYZkb/APdXMqT62++cvpYdTv3aAlKJf3DHyuY=;
 b=fBQNaxUjOZDG4eQhNqnROVOdHshflqkcfkya6YgYMJd6nDXvJbI9WxR0S3ra01W030
 L5uwdBYdbsgwWrZ8k/s+DoVaEoO7djnkx3312DP+awhzX4AnpWucp6ADhZiqoUCxceOI
 Vl1vOgrbrw01s8HMp6srigehuclZ+22K4lpZuY4uyEEqzS/UEGnISwZQ2dwHn7/oeKBg
 WyEeIWYqQt0lEV6eZmFwdhDoK7m59BeuK2O3C1oZDaXUUInTy2lg+9ijE+FmK6z5OYaI
 LgvO7NZnEVhaVy9hfqcyGBSnMAMeGP69VjzjWw4K+WYbk3/BPPwhdxQzdsJaCSU1THjL
 /qEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788269545; x=1788874345;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iri/uHhYZkb/APdXMqT62++cvpYdTv3aAlKJf3DHyuY=;
 b=buTC6AIkF4v7kJ+zMopwwaitcFrLTxSjCnwpmE/IHbervMmdreaN721TG0eetKe3HD
 SrvnL0JuPU7fTRgw1ru8u0kl4CwhAIBh4djUyr7yxaPGr4X0uTxJF24rz7eXitBDi1fk
 JEUoK0vakd/rPf2RlH9YUEEaIkQsHqILhp+eBG0yRjVhTWYHFTX8REIDas+MXRYZ4TBI
 g3QkaUQZj3ZGCrMNCFR8u6onFjExye2emYHRp98Vg7KqM45jbQ7mDwPy1RAjiaAqHzq5
 8282H60w91uReRhUJiJRGjDQ2HUXLSPigZyZR8Cpo7IWwqPcuhggzOwF7PgDxa77ehq5
 qPjQ==
X-Gm-Message-State: AFuF++lsqGRihapAUOCIEJQCuU7aqqvCyDhHvNUnoGk1mWtCauIXT59s
 EERszp23ZAAD6rjdKW+8hqOG8ObyErPG2ebUMJiigKPYuyEmEJLicRXwOtxw1eATDBs=
X-Gm-Gg: AR+sD13U81kpNsAggRDhlzYsmCLGo9tYBrBl1P9Dx3YjejqX8xZNs2fh06E4hYp56ET
 M70u14whNchL4o+SnwqUqATW2meU51Ae8PJrrPLVTSy19/7dlTjjLta4V0DsDjyN+o+fgo376Q1
 TGZtHuBBGVp6di8Ln6xECN2EeVUsk8EAPTDUVezYsw86iJ+8UU6MMzTN5NG9HkIpb5IwkKTR3hd
 XF1pejBC0HLb6qWxlNvJ0JKeB5+4zqaWkYtT6obWGf3igfGW4RLB5g9meR4eGAgUBjD14ZBgL0V
 WB97ueZ+caXksyXf4B6Iyxt6c/UKGrRAC+hOlC1Pgo+/mMPwLjb7wh342VASYljE/OO9fTxfqok
 9f96ZuXfs7NJDzt0RWgzZTLJwEqE/4GDLRfjuPOp7T8EtnmKehOX0fZWuAz/V3dlozS8gt0B0sh
 BGuHf24wTWF17w03ebGzWoH3XiffWN7mmRa9t7vboUdwQSVLPWXFt/3KEI6H82g1f2b1oaIE0=
X-Received: by 2002:a05:600c:530e:b0:49c:dd27:14b4 with SMTP id
 5b1f17b1804b1-49cdd4200bamr93567355e9.7.1788269545351; 
 Tue, 01 Sep 2026 06:32:25 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cdcdd5f5esm64988635e9.0.2026.09.01.06.32.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 06:32:24 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 84EBB5F829;
 Tue, 01 Sep 2026 14:32:23 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  Stafford Horne <shorne@gmail.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Ilya Leoshkevich <iii@linux.ibm.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,  Palmer
 Dabbelt
 <palmer@dabbelt.com>,  Richard Henderson <richard.henderson@linaro.org>,
 Bibo Mao <maobibo@loongson.cn>,  Helge Deller <deller@gmx.de>,  Max
 Filippov <jcmvbkbc@gmail.com>,  Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,  Brian Cain
 <brian.cain@oss.qualcomm.com>,  Song Gao <17746591750@163.com>,  Yoshinori
 Sato <yoshinori.sato@nifty.com>,  Laurent Vivier <laurent@vivier.eu>,
 Nicholas Piggin <npiggin@gmail.com>,  Aniket Sahu <asahu1x@linux.ibm.com>
Subject: Re: [PATCH v8 036/105] tests/tcg/multiarch: declare user tests
In-Reply-To: <20260827221506.91574-37-pierrick.bouvier@oss.qualcomm.com>
 (Pierrick Bouvier's message of "Thu, 27 Aug 2026 22:13:57 +0000")
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
 <20260827221506.91574-37-pierrick.bouvier@oss.qualcomm.com>
User-Agent: mu4e 1.14.4-pre1; emacs 30.1
Date: Tue, 01 Sep 2026 14:32:23 +0100
Message-ID: <87jyp5umfs.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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

Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:

> At this point, those tests are just declared and not used yet.
>
> Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

