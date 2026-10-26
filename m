Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C003606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 07:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FYpTbAu5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLFA4-00080C-UC; Mon, 26 Oct 2026 03:30:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1xLF9v-0007zk-24
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 03:30:19 -0400
Received: from mail-dy1-x1336.google.com ([2607:f8b0:4864:20::1336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1xLF9t-0002bp-Ai
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 03:30:18 -0400
Received: by mail-dy1-x1336.google.com with SMTP id
 5a478bee46e88-35829219da8so4749155eec.0
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 00:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792999813; x=1793604613; darn=nongnu.org;
 h=message-id:date:references:in-reply-to:cc:to:subject
 :content-transfer-encoding:content-type:mime-version:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=EzUKi+uDjtHASUwZbOddqE6vl5cc+Sb3vTLzVZ2gFN4=;
 b=FYpTbAu5fnczoA1xS0pXb31klW4BI/JdYfvEhrRkDFp72VKppB0LSK4oEOfGlXbiJk
 zd8w4xLvhTbLyLkKV9rxT2pojGiS6hkHI38n2/bCPaYgeAafyLFq5lNOG0F+G25HwWPK
 pt01TyptYzXmrt46VjcXWY/aEY32wMWDcDZTSNoqFqfICkhDwZ6AW8xZ+BER2O+s3bcw
 ERIiGdiQEC6SvHZVOKTiHKPhBoYv6mqh+7FN1ZSKU/XlNFmD93oGqL38+cU0/oBnoMTd
 NoyLShsLLNkL7vBAQQ9TMmhkvEjmLeWoAX7OEx1c9nL7t7YX1YsKXswuWwWc7K+PPVKL
 Ix9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792999813; x=1793604613;
 h=message-id:date:references:in-reply-to:cc:to:subject
 :content-transfer-encoding:content-type:mime-version:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EzUKi+uDjtHASUwZbOddqE6vl5cc+Sb3vTLzVZ2gFN4=;
 b=z4ygdZvDUq8361WDXOHx8REL/3cJEQTboFNjlJvzSCaihox6zk7IcfNVac/VvT1327
 xr3q4ydRsKBErlv/jFOC1u4wmD/touzFoDLjw69QgrVxUNmXaiWJ0+pb4OGqAi8RAE6O
 N2nZPjR+bZODExc+pm3fhJ7YtdXEEjj4gTDSxJFIlbE4Hj3bucgptu2UNazxNlUbv9rn
 DXyWCQq2Dl/3Y2nC39CyuK77403/AHryPgFBAvPCU6C+AW1JQ3w4i43UJO4jFQofPIhY
 0RHZwp+9QetkXiVmBPqLRzkMlBzTkT8s4NnIKUM62yahHkW2zmFEjTFDNgdfE8IOG4Sd
 ZZ8Q==
X-Gm-Message-State: AFq9FYJFQVl9BOFZl/n8SBoih59ofukEaVDgW2PcQX2Aj3gBXDn9v/vo
 31ehPfDvN5418S83/KQNWaJU0geCu99+wyX8IN8Y9qdI92oOq3nx+Q8yQ5esSw==
X-Gm-Gg: AYBFou0/hQjW4dtomR/gcdE3Kz8UfU7AJsDOWK2VH2BIf6hsJUYEJju2rcp+TrztKVl
 L/bDkROlL3nukNJ/3Gf3XWsxGS4Bu+Rl7V3JBrMatg3fJsKY2Na10/N7xZnP5IQ4Phs5kHoPiIu
 sElK92HOS1FCGK2V/flJzeHBae1xBFCQTisoowrwZKJqvgwIXrE2xPDb1CQEBGMVRh+p+ZX+fg1
 WlvO9n44NYVDoBOQCIllbZaw7HrLKJqRSV6XG7Ty7c9Ss/vnN28pTarj7HcMrJ4JhOhj469+1gP
 63/v3bSFJw1OCqVku/ouYucvrwQG40PTnuYARVgkIyDLd6EKJCmG5q5IwXW2d9Rmfj0z68boFTX
 5K99cKkz3oPaFGBTekyYSLAOA/hBouBLf3VV6Qj/2vY7DSDgLqAtDNKunDInug+mAtasumYuW1p
 mChnK5ZH+Sad4SlxdDvM0bY2Sd/gUaYD6CdK7Ti64ilO2ayvNeOdWpemqw8/jh28WObi6fuZf2f
 O9Kc6L4L3Bd4BfkKmVn4H7qMNzyBTTV3NQSpc+aB89ZzEqwuCQbxgn4rEx4aj4YYZ3PDiwLo8am
 3Q/IXE6SUa3uIug+daiWzJJ9Hghxe/QzL7fu
X-Received: by 2002:a05:7022:d41:b0:17a:a3d4:8b17 with SMTP id
 a92af1059eb24-1994e81a865mr8444285c88.12.1792999813065; 
 Mon, 26 Oct 2026 00:30:13 -0700 (PDT)
Received: from [127.0.1.1] ([211.226.54.223]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-19894d5a470sm20418976c88.2.2026.10.26.00.30.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 00:30:12 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
X-Google-Original-From: Jeuk Kim <jeuk20.kim@samsung.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 0/8] hw/ufs: Add fault injection, update TMR doc,
 and add qtests
To: Jeuk Kim <jeuk20.kim@samsung.com>, Jeuk Kim <jeuk20.kim@gmail.com>, 
 stanleyjhu@google.com
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Jinyoung Choi <j-young.choi@samsung.com>, 
 Daejun Park <daejun7.park@samsung.com>
In-Reply-To: <20261023113830.3368902-1-stanleyjhu@google.com>
References: <20261023113830.3368902-1-stanleyjhu@google.com>
Date: Mon, 26 Oct 2026 16:29:55 +0900
Message-Id: <179299979556.574876.7191689548887040676.b4-review@b4>
X-Mailer: b4 0.17-dev
Received-SPF: pass client-ip=2607:f8b0:4864:20::1336;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-dy1-x1336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 23 Oct 2026 19:38:22 +0800, Stanley Jhu <stanleyjhu@google.com> wrote:
> hw/ufs: Add fault injection, update TMR doc, and add qtests
> 
> This series adds experimental fault injection to the UFS device model
> so host drivers can exercise task abort and power management recovery,
> updates the task management description in the UFS docs, and adds
> qtest cases for controller reset, MCQ runtime registers, task
> management and fault-injected task abort.
> 
> [...]

Reviewed-by: Jeuk Kim <jeuk20.kim@samsung.com>

-- 
Jeuk Kim <jeuk20.kim@samsung.com>

