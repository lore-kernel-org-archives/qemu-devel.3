Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FDFFC369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 14:39:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9Pct-0005IQ-3z; Mon, 28 Apr 2025 10:38:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <34JIPaAYKCos7tp2yrv33v0t.r315t19-stAt0232v29.36v@flex--seanjc.bounces.google.com>)
 id 1u9Pcr-0005IH-EO
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 10:38:30 -0400
Received: from mail-pg1-x54a.google.com ([2607:f8b0:4864:20::54a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <34JIPaAYKCos7tp2yrv33v0t.r315t19-stAt0232v29.36v@flex--seanjc.bounces.google.com>)
 id 1u9Pcp-000287-NG
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 10:38:29 -0400
Received: by mail-pg1-x54a.google.com with SMTP id
 41be03b00d2f7-b0f807421c9so2696105a12.0
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 07:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1745851104; x=1746455904; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=ku7CAQBt0iZxi6pXBD0e2i82vRUKUPBE8cl/j08mQlU=;
 b=Gz17GpzV8WeqyMBkho5hsT+6+cGxr4VJE1dzejMZBeBx8jszM5l0ROLghtGr4t8SmM
 9g+d0+03UwhZXmwqMOpRXl9kTFgvDqFBiEqBPJgYR0MYFGXiorskAd1FwrvOo36LgBIc
 eqhPrgkKupM9ULfUUGILtIg83hlNb+ZhIBlQZQR6B4yfkCLp2i/8T1/zKDCfkJeR5SDz
 hMASxmWJmbZ0dAUG1Ni/kjlXJGRyB0n8nlMmYs1eZ1G+x5R1aRvWRjBnw69q7TQydIsr
 5hL79Jhb2enkyZNwx1oiKY4xKbY0vZWXqM2QvJ9fvWNMAoIBmwZr4IOL9GqONxLrwBbw
 qvNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745851104; x=1746455904;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ku7CAQBt0iZxi6pXBD0e2i82vRUKUPBE8cl/j08mQlU=;
 b=Ai5H/ZFEpgGhNVspxuJ9cBbkWpRDNBVGMDa8G/Bmw0G99hCRYunwViTriDg91zQkAi
 xwpUJqCmPePPKTGsOzKGuM53d7lObJaCo+1PIU/0RFs/l50L6iBLm1z1A7xykUDscyMX
 n+OlH8/0tEbC79glQBaud46wUPZW7+uvXsll6DMG/WyswLfYMpVSh43IA8JsIIbZvE4q
 Khg2pZyvld9dWUBMjHi3b1YqoabzmoSwetOG6Ifwib5hMvO11Qr7tSMMoI/eWiAjMtod
 goiZuy8JeFJcDA3d5JQ3AwoBjbQ4qx46lLylK2vaYWlwwcmb61m3vtxVFYqSFCff401w
 7tqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbT/JhTaBe76cNuHVan/EaXl1DMU2GCXXvoQNPXXQ2QCr/8rfFc5wqsTQR67gxSh01GrXSiMFcQ6EI@nongnu.org
X-Gm-Message-State: AOJu0YxeUVEViOUvH2XS/Oqr3fRbj6EmCDNqNAJmt4noxS46WTrJ21NN
 MypgBUzV6jAZ6YN0WAT+ATHR0CJ5dC/9I8lcAIEtuhyo8j55hFchG19QYWCgOHFK0g0XILhs2gx
 trg==
X-Google-Smtp-Source: AGHT+IHjirv2d91HZSPSufeRdmuRTR1xvAvnY9B4UmcnLaIp9OEAv5wP443o1wmNtKGzMqRguA3pOsydLQU=
X-Received: from pjbee16.prod.google.com ([2002:a17:90a:fc50:b0:301:1ea9:63b0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:520f:b0:2f9:c139:b61f
 with SMTP id 98e67ed59e1d1-309f8d9b077mr19439971a91.14.1745851104597; Mon, 28
 Apr 2025 07:38:24 -0700 (PDT)
Date: Mon, 28 Apr 2025 07:38:23 -0700
In-Reply-To: <87h629ix3n.fsf@draig.linaro.org>
Mime-Version: 1.0
References: <20250310120555.150077-5-dmitry.osipenko@collabora.com>
 <20250410095454.188105-1-liucong2565@phytium.com.cn>
 <d0e9e72a-02bf-4f1e-abe0-6e8d0d089b29@collabora.com>
 <5514d916.6d34.19622831b11.Coremail.liucong2565@phytium.com.cn>
 <425ebb80-4348-46f3-878b-054800a8fe85@collabora.com>
 <f662c725-e40e-43eb-b155-2440cff34324@collabora.com>
 <2d6e3b03.bb9.1967717fa84.Coremail.liucong2565@phytium.com.cn>
 <87h629ix3n.fsf@draig.linaro.org>
Message-ID: <aA-S35Zw0EXYbDC6@google.com>
Subject: Re: [PATCH v11 04/10] virtio-gpu: Support asynchronous fencing
From: Sean Christopherson <seanjc@google.com>
To: "Alex =?utf-8?Q?Benn=C3=A9e?=" <alex.bennee@linaro.org>
Cc: "=?utf-8?B?5YiY6IGq?=" <liucong2565@phytium.com.cn>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, Jiqian.Chen@amd.com, 
 akihiko.odaki@daynix.com, alexander.deucher@amd.com, christian.koenig@amd.com, 
 gert.wollny@collabora.com, gurchetansingh@chromium.org, hi@alyssa.is, 
 honglei1.huang@amd.com, julia.zhang@amd.com, kraxel@redhat.com, 
 marcandre.lureau@redhat.com, mst@redhat.com, pbonzini@redhat.com, 
 philmd@linaro.org, pierre-eric.pelloux-prayer@amd.com, qemu-devel@nongnu.org, 
 ray.huang@amd.com, robdclark@gmail.com, roger.pau@citrix.com, slp@redhat.com, 
 stefano.stabellini@amd.com, xenia.ragiadakou@amd.com, zzyiwei@chromium.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::54a;
 envelope-from=34JIPaAYKCos7tp2yrv33v0t.r315t19-stAt0232v29.36v@flex--seanjc.bounces.google.com;
 helo=mail-pg1-x54a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

On Sun, Apr 27, 2025, Alex Benn=C3=A9e wrote:
> =E5=88=98=E8=81=AA <liucong2565@phytium.com.cn> writes:
>=20
> > Hi Dmitry,
> >
> > The virglrender patch can fix the virgl issue, but the native context s=
till
> > fails to run on my machine.  I'm not sure if anyone has successfully ru=
n it
> > on an ARM64 machine before.
> >
> > When running with Venus, the virtual machine can successfully run vkcub=
e.
> > However, when using the native context, a KVM error is triggered. Both =
my
> > guest and host kernels are already updated to version 6.14.
> >
> > Here are the commands and error messages I encountered:
> >
> > ```
> > phytium@ubuntu:~/working/virglrenderer$
> > /opt/native-context-v11/bin/qemu-system-aarch64 --machine
> > virt,accel=3Dkvm,memory-backend=3Dmem1 -cpu host -smp 4 -m 4G -drive
> > file=3D/home/phytium/working/ubuntu24.04-aarch64-native-context,format=
=3Draw,if=3Dvirtio
> > -bios /usr/share/AAVMF/AAVMF_CODE.ms.fd -netdev user,id=3Dnet0 -device
> > virtio-net-pci,netdev=3Dnet0 -device
> > virtio-gpu-gl,hostmem=3D4G,blob=3Don,venus=3Don -object
> > memory-backend-memfd,id=3Dmem1,size=3D4G -display sdl,gl=3Don,show-curs=
or=3Don
> > -device usb-ehci,id=3Dusb -device usb-mouse,bus=3Dusb.0 -device
> > usb-kbd,bus=3Dusb.0
> > phytium@ubuntu:~/working/virglrenderer$=20
> > phytium@ubuntu:~/working/virglrenderer$
> > /opt/native-context-v11/bin/qemu-system-aarch64 --machine
> > virt,accel=3Dkvm,memory-backend=3Dmem1 -cpu host -smp 4 -m 4G -drive
> > file=3D/home/phytium/working/ubuntu24.04-aarch64-native-context,format=
=3Draw,if=3Dvirtio
> > -bios /usr/share/AAVMF/AAVMF_CODE.ms.fd -netdev user,id=3Dnet0 -device
> > virtio-net-pci,netdev=3Dnet0 -device
> > virtio-gpu-gl,hostmem=3D4G,blob=3Don,drm_native_context=3Don -object
> > memory-backend-memfd,id=3Dmem1,size=3D4G -display sdl,gl=3Don,show-curs=
or=3Don
> > -device usb-ehci,id=3Dusb -device usb-mouse,bus=3Dusb.0 -device
> > usb-kbd,bus=3Dusb.0
> > error: kvm run failed Bad address
>=20
> That very much looks like a page not being accessible when trying to do
> something.

Yep.  The most likely scenario where KVM_RUN returns -EFAULT is when KVM ca=
n't
obtain a PFN for the faulting GPA.  Odds are good it's this code:

	pfn =3D __kvm_faultin_pfn(memslot, gfn, write_fault ? FOLL_WRITE : 0,
				&writable, &page);
	if (pfn =3D=3D KVM_PFN_ERR_HWPOISON) {
		kvm_send_hwpoison_signal(hva, vma_shift);
		return 0;
	}
	if (is_error_noslot_pfn(pfn))   <=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
		return -EFAULT;

where under the hood, __kvm_faultin_pfn() is a wrapper to gup() and
follow_pfnmap_start() (and some other things).

If you can figure out which GPA is failing, then it's "just" a matter of fi=
guring
out why KVM doesn't find a valid mapping.

