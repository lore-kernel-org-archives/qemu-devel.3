Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D119AC25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 14:38:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBbTw-0004qz-U4; Mon, 27 May 2024 10:37:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1sBbTv-0004q3-Fv
 for qemu-devel@nongnu.org; Mon, 27 May 2024 10:37:47 -0400
Received: from esa14.hc2706-39.iphmx.com ([216.71.140.199])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1sBbTt-0001iS-D5
 for qemu-devel@nongnu.org; Mon, 27 May 2024 10:37:47 -0400
X-CSE-ConnectionGUID: V10O5fe+RVeChR6zWKr+gA==
X-CSE-MsgGUID: Ea5bNn0KTQqMIYaUAy85hA==
X-IronPort-RemoteIP: 209.85.219.69
X-IronPort-MID: 405221625
X-IronPort-Reputation: None
X-IronPort-Listener: OutgoingMail
X-IronPort-SenderGroup: RELAY_GSUITE
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:LoMTW6gywiW56c+Nl8AmHyJzX161LhEKZh0ujC45NGQN5FlHY01je
 htvWmqFOa3YMGOkfY13PIW18EkB65bRmtFhSVFurShkE3sW8JqUDtmndXv9bniYRiHhoOOLz
 Cm8hv3odp1coqr0/0/1WlTZhSAhk/zOH/ykVbOs1hlZHWdMUD0mhQ9oh9k3i4tphcnRKw6Ws
 Jb5rta31GWNglaYCUpKrfrTwP9TlK6q4m9A4wZhPakjUGL2zBH5MrpOfcldEFOlGuG4LsbiL
 87fwbew+H/u/htFIruNjrbhf0QWdaXZNA6Ih2A+c/DKbs9q/3FaPg4TbZLwWG8O49m7t4kZJ
 OZl7PRcfTwU0pjkw4zxZfX5/xZWZsWq8JefSZS2XFf6I0fuKhMAyN03ZK060BFxFk+azgii+
 NRBQA3hYCxviMqImeqcF+dhxf4dIeLrBt0NhVJ6jj7wWKNOrZDrG80m5Pdd1TY0w9lQRLPQO
 ZtfZj1oYxDNJRZIPz/7CrpkxLbu1iS5KWQJ7gzEzUY0yzG7IAhZ2bz9NtbPUtaXA8hZgy50o
 0qapzmjWEhEboH3JTyt33vxjMnJxQDHYZs3NYyxy9d70ACT7zlGYPERfR7hyRWjsWanVtdCb
 kAZ5Ccqha418kOtU5/6RRLQnZKflhsVWt4VCvNjrQ/Tm+zb5AGWAmVCRTlEADA7iPILqfUR/
 gfht7vU6fZH6dV5lVr1Gm+okA6P
IronPort-HdrOrdr: A9a23:eDbIj6oqjcKYeXfVfK7PyiUaV5oSeYIsimQD101hICG9E/bo7v
 xG+c5x6faaslgssR0b9Oxoe5PwJE80jKQV3WBJB9eftWrdyQiVxeNZnO3fKlTbckWVygc679
 YDT0EUMrLN5DZB4foSTTPId+rIhOP3l5yVuQ==
X-Talos-CUID: 9a23:NrzEy27TYqBUDWuD6tssyhdMPZ0rfz7n8nr7I3XmG1lKUv6aYArF
X-Talos-MUID: 9a23:BtNyDQohf2OpFzyEzm8ezxxrac1O5fyNNHkUtLQ3svStJHwtOx7I2Q==
Received: from mail-qv1-f69.google.com ([209.85.219.69])
 by ob1.hc2706-39.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 27 May 2024 10:37:42 -0400
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6ab80cb23beso28531736d6.2
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 07:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bu.edu; s=s1gsbu; t=1716820661; x=1717425461; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nkPG3jllJ8mpfniPZ1E290T5E8Gj6w+YnBaHKoqcRWQ=;
 b=i/lDesG3aro/XRPX68UF73lnAccSaVCMwW12Lhpr0DPwIfMFdasqbC32YLu9pKuH6D
 D2LxJE60Zao9nk2cgw0MRTk5BrNZxCycWHti5HAIzHmZAYlnNQYxYN35nUU0H/pQqIA/
 m3N9WJgeiRsSBN37TCv99G9kRuDXBZuiU7zLvPm0zmOhiX+0x5ZLbJptmB72RPOxyg7p
 zw6+hdb3Jsc/yDmiasP4PaHwLDOMtwzWJGvRJ+oaT5nXPAOUXEXwUa+fJrPWHRATH1SB
 bHHtD3dvhzWb07J3fX1sQnOwTYW3V6BhGelj8wIkUH8lVwZ9tWKttPy7U6esn6HUlNOo
 Urfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716820661; x=1717425461;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nkPG3jllJ8mpfniPZ1E290T5E8Gj6w+YnBaHKoqcRWQ=;
 b=rU5rGgO6Y6vZYIT0DrzfVw8mI48CgIhjuPLpuwaLbHjHLM4L+zl6EQFdz25bzdFUev
 ea0fc0p+9zpbve52Bdb1IMXzRsv394/59ZpqhH+jQiCbTTnmBrDpdjVh56tCQLZeENrQ
 t8GzyIFfUyhFSYfx6yPxsgoyekGlETXHOjkp1fqyshQXqeJs8xHqAnFb8gZETC4dNKLZ
 e+6XyRHhNBWtiPhKZLY8rFxfSaQTi7enu/e5JaNjBe6S0BTxZqXb2QacsaXZnUVwbIed
 LeOHqhrIf+/+9Ph68LCfmRavVdlBc5ILB12SgY/vniOcgys9UzPbY+moR+m+Iqn3K0tK
 iPEQ==
X-Gm-Message-State: AOJu0YyRDRi8p9ZvqvAowhBP9QWyH+P/KHNATWPCweXxa5uHNiy+HAy9
 hPYMyEkOVkuKGXCRW3ckNNmxvbYUFZKoJNRcUHKI+z/S2/Dn+wxMPssCdvnWTReO2pmL70z88Jy
 y9B5oT+R0hK8P8bbe5FmLVBdiXsaezwBh2A/Ft47eXyRvxezhiBK7ADZgwZyoN+CLKg==
X-Received: by 2002:a05:6214:84c:b0:6ad:6ea7:b261 with SMTP id
 6a1803df08f44-6ad6ea7bd3fmr59648346d6.23.1716820661236; 
 Mon, 27 May 2024 07:37:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2ch2frOVSW3QGY+bVRKhnWgIljcIL11Kpk9nlhpTRwzgIXizE9f3yda7Df3suR9tndcRw9w==
X-Received: by 2002:a05:6214:84c:b0:6ad:6ea7:b261 with SMTP id
 6a1803df08f44-6ad6ea7bd3fmr59648056d6.23.1716820660853; 
 Mon, 27 May 2024 07:37:40 -0700 (PDT)
Received: from mozz.bu.edu (pool-173-48-150-109.bstnma.fios.verizon.net.
 [173.48.150.109]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ad71e72d8bsm20886656d6.121.2024.05.27.07.37.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 07:37:40 -0700 (PDT)
Date: Mon, 27 May 2024 10:37:37 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Bandan Das <bsd@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>, Qiuhao Li <Qiuhao.Li@outlook.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH] fuzz: specify audiodev for usb-audio
Message-ID: <20240527143737.4g344b6agow4sel4@mozz.bu.edu>
References: <20240527040711.311865-1-alxndr@bu.edu>
 <87ce6185-7244-4cc1-9a91-9b07fc7665ee@redhat.com>
 <20240527140711.ecy5zql7oq34rwjp@mozz.bu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527140711.ecy5zql7oq34rwjp@mozz.bu.edu>
X-CES-GSUITE_AUTH: bf3aNvsZpxl8
Received-SPF: pass client-ip=216.71.140.199; envelope-from=alxndr@bu.edu;
 helo=esa14.hc2706-39.iphmx.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 240527 1007, Alexander Bulekov wrote:
> On 240527 0734, Thomas Huth wrote:
> > On 27/05/2024 06.07, Alexander Bulekov wrote:
> > > Fixes test-failure on Fedora 40 CI.
> > > 
> > > Reported-by: Thomas Huth <thuth@redhat.com>
> > > Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> > > ---
> > >   tests/qtest/fuzz/generic_fuzz_configs.h | 3 ++-
> > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/tests/qtest/fuzz/generic_fuzz_configs.h b/tests/qtest/fuzz/generic_fuzz_configs.h
> > > index 4d7c8ca4ec..ef0ad95712 100644
> > > --- a/tests/qtest/fuzz/generic_fuzz_configs.h
> > > +++ b/tests/qtest/fuzz/generic_fuzz_configs.h
> > > @@ -150,7 +150,8 @@ const generic_fuzz_config predefined_configs[] = {
> > >           "-chardev null,id=cd0 -chardev null,id=cd1 "
> > >           "-device usb-braille,chardev=cd0 -device usb-ccid -device usb-ccid "
> > >           "-device usb-kbd -device usb-mouse -device usb-serial,chardev=cd1 "
> > > -        "-device usb-tablet -device usb-wacom-tablet -device usb-audio",
> > > +        "-device usb-tablet -device usb-wacom-tablet "
> > > +        "-device usb-audio,audiodev=snd0 -audiodev none,id=snd0",
> > >           .objects = "*usb* *uhci* *xhci*",
> > >       }
> > 
> > Reviewed-by: Thomas Huth <thuth@redhat.com>
> > 
> > The patch makes sense and I think we should include it, thanks! .. but I
> > still don't understand why the behavior of the fuzzing job was different
> > between Fedora 38 and 40, do you? Why does it complain about "no default
> > audio driver available" on F40 but works fine on F38, though both build jobs
> > include the Alsa, pulseaudio and OSS backends?
> > 
> 
> Yes that's strange, if the behavior is different.
> The full config here is:
> 
> .args = "-machine q35 -nodefaults "
> "-drive file=null-co://,if=none,format=raw,id=disk0 "
> "-device qemu-xhci,id=xhci -device usb-tablet,bus=xhci.0 "
> "-device usb-bot -device usb-storage,drive=disk0 "
> "-chardev null,id=cd0 -chardev null,id=cd1 "
> "-device usb-braille,chardev=cd0 -device usb-ccid -device usb-ccid "
> "-device usb-kbd -device usb-mouse -device usb-serial,chardev=cd1 "
> "-device usb-tablet -device usb-wacom-tablet "
> "-device usb-audio"
> 
> This contains "nodefaults", which should always be causing the error,
> since this change:
> c753bf479a ("audio: disable default backends if -audio/-audiodev is used")
> 
> This adds audio to qemu_disable_default_devices, which should be called
> by -nodefaults. I wonder if for some reason the order in which the
> audiodev is configured and the default audiodev is disabled is different
> between builds.
> 

It might be even simpler. The recent jobs on Fedora 38 don't seem to
ever even make it to the xhci test, because of a detected leak:

https://gitlab.com/qemu-project/qemu/-/jobs/6949417820#L4375

