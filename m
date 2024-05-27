Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18400C25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 14:10:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBb2u-0002ZP-LE; Mon, 27 May 2024 10:09:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1sBb2t-0002Yu-MT
 for qemu-devel@nongnu.org; Mon, 27 May 2024 10:09:51 -0400
Received: from esa13.hc2706-39.iphmx.com ([216.71.137.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1sBb2r-0005K8-Gt
 for qemu-devel@nongnu.org; Mon, 27 May 2024 10:09:51 -0400
X-CSE-ConnectionGUID: 0PhOTP+eSlCsN75khgy9QA==
X-CSE-MsgGUID: GzDDcX5iRmGYa4g4sSp0nQ==
X-IronPort-RemoteIP: 209.85.222.200
X-IronPort-MID: 367299942
X-IronPort-Reputation: None
X-IronPort-Listener: OutgoingMail
X-IronPort-SenderGroup: RELAY_GSUITE
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:v6oSIK9TY0siDFTGu9fMDrUD1X+TJUtcMsCJ2f8bNWPcYEJGY0x3x
 2MXDWmPa6zeZGujLt8gO4nl9h4EuJSAnIVrHlQ9rykxFiIbosf7XuiUfxz6V8+wwmwvb67FA
 +E2MISowBUcFyeEzvuVGuG86yQ6jOfQG+eU5NfsYkhZXRVjRDoqlSVtkus4hp8AqdWiCkaGt
 MiaT/f3YTdJ4BYqdDpEg06/gEk35qiq5WlH5gVWic1j5zcyqVFEVPrzGonsdxMUcqEMdsamS
 uDKyq2O/2+x138FFtO/n7/nRVYBS7jUMBLmoiI+t3+K20UqSoQai87XBdJFAatlo2zhc+NZk
 b2hgaeNpTIBZcUgrgi8vy5wSEmSNYUekFPOzOPWXca7liUqeFO1qxli4d1f0ST1NY+bDEkXn
 cH0JgzhYTjbv+KR/Ir4R9Jord8Fc5ToPIwO60hJmGSx4fYOGfgvQo3P7N5cmS4z34VAR66GI
 cUebjVrYVLLZBgn1lU/Uspv2rf1wCOlKXsC8Ar9SakfugA/yCR41KjrPMD9cMHMSMlI9qqdj
 jmYoD6oU0BGbrRzzxKq4F6Ajd+SnBn+d7MbSLLk7cVy2Fuqkzl75Bo+EAHTTeOColezXs8aJ
 0EK9y4Gq680+0q2CN7nUHWFTGWsuxcdX59JELR/5lvVkuzb5AGWAmVCRTlEADA7iPILqfUR/
 gfht7vU6fZH6+bMIZ5B3t94dQ+PBBU=
IronPort-HdrOrdr: A9a23:YTK1zqFRJZzgVjvnpLqE1MeALOsnbusQ8zAXPiFKOH9om6mj/f
 xG88526faKskdpZJhNo7690dC7MBXhHMdOkO4s1NSZPDUO2lHEEGgK1+KLqAEIcBeQygcy78
 ZdmxYSMqyTMbDH4PyKhDVRrLsbsby6zJw=
X-Talos-CUID: 9a23:iyIX82PPgLA1/O5DABFn03IsWc0edlbG6iiNIE+3GDdQYejA
X-Talos-MUID: 9a23:RzyQHwpS1kd09hbYljAezx5wGOtj0/mvMkUioJxatJWfDjQoPQ7I2Q==
Received: from mail-qk1-f200.google.com ([209.85.222.200])
 by ob1.hc2706-39.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 27 May 2024 10:07:16 -0400
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-794ab2615f4so440618585a.3
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 07:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bu.edu; s=s1gsbu; t=1716818836; x=1717423636; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xyWf/S4cbPVDaqXPk/EBP2HsTEI1V6ymZ8Ugc/CKw9s=;
 b=dUgsv4bR+EnHG7CTfLCUi8dZgGr6hWzz7LAH7+Q8JlXAWkfAsGXpeE4mjDKEYxEF/d
 pj0tZzVKUuSh1AXwFU6W9aoJKlDudgrzgaDRs7MLHzn/S66PWDkoYwxkLwIth6UqxBpK
 m1pUAK7CuD6hj7u+qUZWisTbZkDOXEVICFg3U8sQ0Hokyz7IzjmZyWRYLj49lmpWzyJu
 nHhiUtDqX7bJPi23vJO5bGrZ+0yKmZFeTaiPim0VBKPTuwwwZzHOrlsXDFPdLeJX7Q6i
 JB/n8m/KfVc9IXn7wK85sGhLFkTkp0OwX6sNooKRJEE726fCpr7+6+Y88701SoTt/HE8
 DpwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716818836; x=1717423636;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xyWf/S4cbPVDaqXPk/EBP2HsTEI1V6ymZ8Ugc/CKw9s=;
 b=s6kJTXxoUxvLF1qm400FmIIwLdyycxnnUWt2PL1kVZm+kVhkuXFy0wstLJo4PXQvUJ
 XqbJKcT3H9EBVx73EMpIOwQJudXxwXdaEmy9ONbNWlAIgzj25uRsimNlgHEIpBPGDGPe
 d4XAq6Ucymh2IkWqKHto1F5DlSJ7rYOKeDJsPVQ8smRgI2qWI7nkhvn8DdZuTXDlJFiU
 EWi4lqg3IRBYdxt9lsqlDYC9CalmsL8wBFfxfJyml9nNsqgPW9IsddP+J2lRSxWefDB8
 HgPkAXhRyfuXSg7W6gDmJbQtE7mELGR2uulVJP2FkpWQHkcM+TovUZXp6bFcnARs4vXf
 RQTg==
X-Gm-Message-State: AOJu0Yy5aZDPCeKDX5PVsB0bTAdh2EEwxehf46Mx7+8aLW85HPRtMga3
 U3PtcQZXr0Ur4k4GAEusRlngP5SPiwIIWa9k9sBqd34PLlGJx/HtmVOG+z/8KmxszlDxL9wQqlo
 j/dhzSSQEGvtqryp1c76hNK9pHXMt2FfP8Z7qHVpe9O3ai+70/jYtD1GEti7Qjj6pRw==
X-Received: by 2002:ae9:c010:0:b0:792:c268:fbf0 with SMTP id
 af79cd13be357-794ab055030mr1004246885a.6.1716818836192; 
 Mon, 27 May 2024 07:07:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbVm1TJq3U0PsHsbhFsQbjjyfIKS9FtNyg0OLdz1S3OYj9YYqj97x5Pnoj4GsfDJRoy9DZIg==
X-Received: by 2002:ae9:c010:0:b0:792:c268:fbf0 with SMTP id
 af79cd13be357-794ab055030mr1004243385a.6.1716818835770; 
 Mon, 27 May 2024 07:07:15 -0700 (PDT)
Received: from mozz.bu.edu (pool-173-48-150-109.bstnma.fios.verizon.net.
 [173.48.150.109]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-794abd0845dsm299105685a.91.2024.05.27.07.07.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 07:07:15 -0700 (PDT)
Date: Mon, 27 May 2024 10:07:11 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Bandan Das <bsd@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>, Qiuhao Li <Qiuhao.Li@outlook.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH] fuzz: specify audiodev for usb-audio
Message-ID: <20240527140711.ecy5zql7oq34rwjp@mozz.bu.edu>
References: <20240527040711.311865-1-alxndr@bu.edu>
 <87ce6185-7244-4cc1-9a91-9b07fc7665ee@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ce6185-7244-4cc1-9a91-9b07fc7665ee@redhat.com>
X-CES-GSUITE_AUTH: bf3aNvsZpxl8
Received-SPF: pass client-ip=216.71.137.83; envelope-from=alxndr@bu.edu;
 helo=esa13.hc2706-39.iphmx.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 240527 0734, Thomas Huth wrote:
> On 27/05/2024 06.07, Alexander Bulekov wrote:
> > Fixes test-failure on Fedora 40 CI.
> > 
> > Reported-by: Thomas Huth <thuth@redhat.com>
> > Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> > ---
> >   tests/qtest/fuzz/generic_fuzz_configs.h | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tests/qtest/fuzz/generic_fuzz_configs.h b/tests/qtest/fuzz/generic_fuzz_configs.h
> > index 4d7c8ca4ec..ef0ad95712 100644
> > --- a/tests/qtest/fuzz/generic_fuzz_configs.h
> > +++ b/tests/qtest/fuzz/generic_fuzz_configs.h
> > @@ -150,7 +150,8 @@ const generic_fuzz_config predefined_configs[] = {
> >           "-chardev null,id=cd0 -chardev null,id=cd1 "
> >           "-device usb-braille,chardev=cd0 -device usb-ccid -device usb-ccid "
> >           "-device usb-kbd -device usb-mouse -device usb-serial,chardev=cd1 "
> > -        "-device usb-tablet -device usb-wacom-tablet -device usb-audio",
> > +        "-device usb-tablet -device usb-wacom-tablet "
> > +        "-device usb-audio,audiodev=snd0 -audiodev none,id=snd0",
> >           .objects = "*usb* *uhci* *xhci*",
> >       }
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 
> The patch makes sense and I think we should include it, thanks! .. but I
> still don't understand why the behavior of the fuzzing job was different
> between Fedora 38 and 40, do you? Why does it complain about "no default
> audio driver available" on F40 but works fine on F38, though both build jobs
> include the Alsa, pulseaudio and OSS backends?
> 

Yes that's strange, if the behavior is different.
The full config here is:

.args = "-machine q35 -nodefaults "
"-drive file=null-co://,if=none,format=raw,id=disk0 "
"-device qemu-xhci,id=xhci -device usb-tablet,bus=xhci.0 "
"-device usb-bot -device usb-storage,drive=disk0 "
"-chardev null,id=cd0 -chardev null,id=cd1 "
"-device usb-braille,chardev=cd0 -device usb-ccid -device usb-ccid "
"-device usb-kbd -device usb-mouse -device usb-serial,chardev=cd1 "
"-device usb-tablet -device usb-wacom-tablet "
"-device usb-audio"

This contains "nodefaults", which should always be causing the error,
since this change:
c753bf479a ("audio: disable default backends if -audio/-audiodev is used")

This adds audio to qemu_disable_default_devices, which should be called
by -nodefaults. I wonder if for some reason the order in which the
audiodev is configured and the default audiodev is disabled is different
between builds.


