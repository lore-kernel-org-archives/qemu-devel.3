Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CF84CCD185
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 14:23:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6rXR-0006A2-VX; Thu, 09 Oct 2025 10:22:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lleonard@redhat.com>)
 id 1v6r2V-0006vy-LP
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 09:50:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lleonard@redhat.com>)
 id 1v6r2R-0005u1-Uh
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 09:50:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760017830;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=qU6zMeJ0/ARZy55R8Auba5Y3tNCmNLUYpGMtFIVjVPg=;
 b=fFbOEDyN2mBsKxOZ3pBGkVd5pXkvvP41l3HJHFBehblpchjYAFBzX1wESJSkwv96YAE/ZC
 9dINhB9hl8z35LeEV+Pfy6826Z46skfgZN8gTCREo5ln6saqWx3nQb7dv+3CwHadI+RGWh
 zEE838ImYfc25KnsoUvHYxFxgvkPTwU=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-VgHG1N_QPcGv7B3p4F-b4w-1; Thu, 09 Oct 2025 09:50:28 -0400
X-MC-Unique: VgHG1N_QPcGv7B3p4F-b4w-1
X-Mimecast-MFC-AGG-ID: VgHG1N_QPcGv7B3p4F-b4w_1760017828
Received: by mail-yx1-f71.google.com with SMTP id
 956f58d0204a3-63b781aecedso1879108d50.3
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 06:50:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760017828; x=1760622628;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qU6zMeJ0/ARZy55R8Auba5Y3tNCmNLUYpGMtFIVjVPg=;
 b=nwMFHfxKKCt5S1qzo10uZPA9WR6DHW6oMtB7xNjJl+IQ34Wen3enGD0PhnHEvCcQSb
 tRJ3LpmqwpwicDqMQwYB+yvHTgJSWf5HpSKCQ/8A4F/glUa6QgIq6xoQ/dEHSoUM3SF1
 T4JGWUoElKiqq34FF36WPxogxcZxNF8ISmPTKg/atkfyMvzpclRMLt17nQnGP3b4l+bd
 xdtGV/FqQ4RTCxrOlfql5n/fy5CLnZgP/+RkkCCfLsBbTVBGzKQJjM3vuCuEvXlyEq+G
 y0IY6FZQTF6nfAEt3QLyR0R7ds18QNJ3c0+IfrOijzafH+Ltm6qABOHfHquEg09x1MTg
 lQdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQI66HA0MF4rHbJ20brMrNKsAd0eVCoKMoiTfURRzEBSbrRCxcu8tAFG/aZitcsWpTwo3TD38b7Nt7@nongnu.org
X-Gm-Message-State: AOJu0YxsOYwbHw5qOmr9PdPD1Pr3Sgp2SFlFjqxTlU1GekZuirZSrf+X
 zBiCUB3kfEiElbD3rrc5E5Uh8hH+zYii89ltvE6lGXDde6nV2kQFp4DPoHaesidd5oRXRE1Xl9g
 uXLUxsnFku9v6MMD5JNLqxdl4N1tsKNKhHlNC7sVi3sNSC4iRTZ1qq10nphsrl2D5TFJEaB5Lkl
 sZsVh4+B8N8D0eLM4YDfPPl4wP6MW6qts=
X-Gm-Gg: ASbGnctfTcWUchoiOx8PUyZRYQZdDaIdH2LDDJjXpkvfGsElTU+FcM5phRuDDaMhaP2
 qfHq7BT+bBPBDsJOAMyYtFdKyGO6oh07AzNafIci+sr7JLRJQzY8RmCaIEu4gOReOL9T+oN+99L
 HI5M8mk52qRJRPGhz83k4fB7ZeoQ==
X-Received: by 2002:a53:b888:0:b0:635:4ed0:5714 with SMTP id
 956f58d0204a3-63ccb931f6amr5162003d50.46.1760017828275; 
 Thu, 09 Oct 2025 06:50:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvBVG6OOJLJG8wsYJg/5ahBsnr1oj1rBS5B5SzEro2Z3CngB550GzypHOyBlaSfKeOn7fxIJd4umWwhBggSMU=
X-Received: by 2002:a53:b888:0:b0:635:4ed0:5714 with SMTP id
 956f58d0204a3-63ccb931f6amr5161993d50.46.1760017827901; Thu, 09 Oct 2025
 06:50:27 -0700 (PDT)
MIME-Version: 1.0
From: Luigi Leonardi <leonardi@redhat.com>
Date: Thu, 9 Oct 2025 15:50:17 +0200
X-Gm-Features: AS18NWBozEpO0MjfGnF71tqkXqaQvBfG3uDo70enT-b8KfeWrKaqC0uQNgGGWEI
Message-ID: <CANo9s6nV-gUFKqxaOqH7qFzLTdY3RcA=WYhhcQhdQpMXQG=Qpw@mail.gmail.com>
Subject: SVSM device assignment: device tree support
To: joro@8bytes.org
Cc: coconut-svsm@lists.linux.dev, qemu-devel@nongnu.org, 
 Stefano Garzarella <sgarzare@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Oliver Steffen <osteffen@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lleonard@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 09 Oct 2025 10:22:31 -0400
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

Hi Joerg,

I am working on device tree support for SVSM to allow it to discover
MMIO devices that should be used only by SVSM.
In this way we can differentiate the devices attached to VMPL0 and
VMPLX. As we discussed in the SVSM community call,
we can use IGVM to expose the device tree to SVSM. This should be
generic enough to be supported by any hypervisor
(vs the PoC we currently have that uses the fw-cfg).

My idea is to use the IGVM directive "IGVM_VHT_DEVICE_TREE", basically
replicating what was done for MADT,
allocating a page (maybe more?)  for the DT blob, using a new index
for the parameter area.

I think that the DT parameter, just like MADT, should be marked as
optional for now, as not all hypervisors support it.

For the QEMU support, I had an offline discussion with Stefano, who
suggested creating a new object (for example "svsm-devices")
where we can specify all the devices that need to be attached to SVSM.

something like this:

-machine [..] svsm-bus=bus1
-device virtio-blk-device,drive=svsm_storage,id=dev1
-object svsm-devices,id=bus1,devices=dev1,dev2,dev3

This object would be in charge of creating the DT.

Note that we are not sure if it's doable or not, we still need to
investigate the best QEMU interface.

What do you think? Do you have a different idea for the DT support?

Of course I am very open to suggestions and comments from everybody.

Thanks,
Luigi

PS: sorry to send this again, I accidentally didn't set plain text
mode and was rejected by the ML.


