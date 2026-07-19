Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 518B6C4451B
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jul 2026 15:18:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlTGl-0000GW-D4; Sun, 19 Jul 2026 11:17:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pyudistira519@gmail.com>)
 id 1wlRjq-0002ok-Me
 for qemu-devel@nongnu.org; Sun, 19 Jul 2026 09:39:26 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pyudistira519@gmail.com>)
 id 1wlRjp-0006K3-Cj
 for qemu-devel@nongnu.org; Sun, 19 Jul 2026 09:39:26 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-37f9e2642deso990262a91.1
 for <qemu-devel@nongnu.org>; Sun, 19 Jul 2026 06:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784468363; x=1785073163; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=IR5uAPYdVCUAcHygxYED9bpVm/yTohC0k2jroQ3jPbs=;
 b=iRZYTodazrE7FlEnQbmTkPE+bgBbo+szFa95F903hEBVusrOQKpdKMG73pXOqk19Sm
 il7I3GTBZnbQuDL6CR9E5xZh7oGRdkEaAX5mBUlpgvRS0orW67akB5VPnLr1IzapiP0d
 QR0vpuEByiz4FNjpm0lWExO8eitTHqZgIRtjpvh8c9Cd7MVBIVGdR8tTFMLd2WoGZ9bt
 0o/Qd7ZT+MrvXgzExtj/OkIgwWltbPNHJj0q5+AfyPC+GcMWLfHGdLw8/BCtp8SWPrC8
 jPL5F9Xlt/6VfG8S90WIaWT/a6rZq8WJRdtXzd6DWBMOCRQ5B1rspXHnDHDyw3VR68Op
 KbBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784468363; x=1785073163;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IR5uAPYdVCUAcHygxYED9bpVm/yTohC0k2jroQ3jPbs=;
 b=GRAb3hIpa5CqMn0wt4YVPIed9IAdYG7ZNqHfZwX7AMXRwWKvA/YbxNR5u3g/1vBC87
 mqydF2ZerbMJjPvEV6xIGJXXn31KNXeZ3V815Ei6BbwsA5Gs7T7T+4E+SnKDr1awGLY8
 hTYl4zQvhT/J/aXDo+8gAQft54ivjycNLTbXyl1fuyJsHOWKH7v4r6p/mwa0/2Hy+vj3
 npaBIsqeZdpOcXappFAgT2HOh0lBBHUv3dStLWqsGOOXZzGIFxbMaMpUsDr8PADfMzhs
 If95bFODupR0tB5fdTXKYJFuWiwwqMxOUL7UCJbHBDu43FrLCARGnVBJRKBYLDp/m66Z
 bU/Q==
X-Gm-Message-State: AOJu0YzUpPnCAXwTjg2VWNfN2C/dxI3sjUgZi1liDl72elEzmMoDkJ8A
 mmT4IqnnA/7qi1zm7jcYJSa1AoR2JSqw21ua/ublJbPEFUDVudViBifE94DdBlsg
X-Gm-Gg: AfdE7ck5uXUiP/RL+oGo7802wROBVZ6bS6jChR3yZR66YCkgc/So808z6kmcGV7aXO9
 aMiDD4dcoeSDBhqpIwmJv3PbSjBgbmMLBigS5TRB+Cj5Oc7CJwJOylqFf0n+MZ2xNx1rgs2LJZm
 7RItPFPzH63m/57H/17Cun14KJUqOq7fp1pPfpKT6eHr5V/DBcStCFZy6zxYBq8vCzolGvANy+S
 RqdlZyDjgXP6y9d/bHhEISqtquAv9Ue0pdT77pJbINUrE3DDhJ3AQ8vqZCtv5y48PE3ld6OefVB
 kzhzcwUm2Vh+r6vPEvpwET/FLMUIGK8cp+yB3lki7Lp6Xiuyrww1HqeR5SEkSS3jlC7Zq15sWqD
 Ly5QAsn7rBrmDOni0CAY/PZs9lnUQLuh5WSIWSFTibjl+d7DWssrpnr0WsGq/wlKc9MXirk9aqR
 QQSHX37hsuYe+G99M+ZLNkIw==
X-Received: by 2002:a17:90b:3f85:b0:38e:480b:99a5 with SMTP id
 98e67ed59e1d1-38e4b3e228emr7882612a91.2.1784468363203; 
 Sun, 19 Jul 2026 06:39:23 -0700 (PDT)
Received: from pop-os.. ([114.10.27.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3142a1de21asm26899678eec.23.2026.07.19.06.39.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Jul 2026 06:39:22 -0700 (PDT)
From: Yudistira Putra <pyudistira519@gmail.com>
To: qemu-devel@nongnu.org
Cc: jos.craaijo@ou.nl,
	Yudistira Putra <pyudistira519@gmail.com>
Subject: Re: [PATCH] target/i386: fix long mode segment override prefix
 decoding
Date: Sun, 19 Jul 2026 09:37:34 -0400
Message-ID: <20260719133734.253264-1-pyudistira519@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260623-fix-x86-long-mode-segment-override-decoding-v1-1-26d9d4b5804e@ou.nl>
References: <20260623-fix-x86-long-mode-segment-override-decoding-v1-1-26d9d4b5804e@ou.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=pyudistira519@gmail.com; helo=mail-pj1-x102b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 19 Jul 2026 11:17:21 -0400
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

I tested this patch on an x86_64 Linux host using QEMU x86_64
linux-user TCG.

Native execution completed successfully with exit status 0. Clean QEMU
reproduced the failure with SIGSEGV and exit status 139. QEMU with this
patch applied completed successfully with exit status 0.

Tested-by: Yudistira Putra <pyudistira519@gmail.com>

