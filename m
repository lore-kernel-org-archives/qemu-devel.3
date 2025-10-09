Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FBE2CCD185
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 14:23:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6rXO-00069k-7D; Thu, 09 Oct 2025 10:22:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lleonard@redhat.com>)
 id 1v6qaZ-00009v-0T
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 09:21:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lleonard@redhat.com>)
 id 1v6qaV-0001z0-BD
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 09:21:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760016093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=7I5DuznOvQGmK/lBgOwv8Tm6BvRlembtN0rWzPUlQIo=;
 b=BWB5JMeHG1uIiNIKAd/CJoMQ9YhNAZDam5hxSZaiwQtXSFqXA7+E/MLO5ShSg4OU20hwC7
 n8dmEuWkmPbStACM9LwvLTNLUTBIPguVfmFQAXOteLtOHdvVnColht1bs4mPc+R9HfSJVk
 fDlNfUWdYl6EwnOvUDXpa/8+SImmF1Q=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-UGgkrNd-MLG0nEEbtuK8yQ-1; Thu, 09 Oct 2025 09:20:20 -0400
X-MC-Unique: UGgkrNd-MLG0nEEbtuK8yQ-1
X-Mimecast-MFC-AGG-ID: UGgkrNd-MLG0nEEbtuK8yQ_1760016020
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-77f98d8fff8so20150547b3.1
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 06:20:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760016020; x=1760620820;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7I5DuznOvQGmK/lBgOwv8Tm6BvRlembtN0rWzPUlQIo=;
 b=CsYM3IcLuEyKbiVFfADYy37/JTsbKnaBDqNC/runfcdKEGI9QjULQNC1nXfrQhlzOv
 69yEXo2tr4JXpI2gZaYyVTPGXjS33YoQCh+o2zGeU6gcW6aCLLA6csngl1tYlKUWFQOl
 PcP4nANYVkDKhdU1qBlficg3K2nA0Rhruorq4z4yWvNA5muT5++SQ76OoScWffmDfZzo
 FhOicLHv5oyHJRB0jj+25K/eKCwLYaaotsEmPO1R6vL11KbpCaAMLbSFMiX1XdJIIo6P
 L/1YdLn5NjEDo2T5xhAl1yI/44iB/3Zl8hfijoQ/cNQ1l0GqTv1+pebTkuMTPjqWIBro
 Wsnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaRExWa+lLe4ycayZo5wZLVUQr84pVFz3PhWRxqXGINj//NyN9KqY4jUti/VW9Aqh5/gWeNBsI0oCs@nongnu.org
X-Gm-Message-State: AOJu0YxwQVmYjjIKe5KgSSHOxWNiQy4lY/PhvBatX2aFKAz4k8u1mMCH
 xDHfmI6V+P67NVt5SMWR/lY2iAz00U8ol/2BntarpVbujCwuX9F/N5r9FmKSB/hD1rr6RTqnMPF
 yp5KQ+RBCpDHFOuZHpawTiuMzXvff2dDjAxeM2vjaopFXnhEQCptNajkc28t3lTElJ7v6Efgsl1
 8927QSRE7F/p0SOUTaXnxRD+YoLQmt9EM=
X-Gm-Gg: ASbGnctp/BvdtRMFNukTLF7zK41DJ9EHAshEeEoTNmkXC9Jk1uA0QstVkQPBIDaNo84
 keYqQpz87Oh3VN4k8+th3u6jdtv9Z9YHdpAqbmP7glFBBAwl1AsIvGokrqO0yLiBygCG/Wy7Xgx
 HIZClmSDFJYT5tAV2CO7vS6axDng==
X-Received: by 2002:a53:b685:0:b0:633:c22b:f0b2 with SMTP id
 956f58d0204a3-63ccb81364bmr5215196d50.7.1760016019687; 
 Thu, 09 Oct 2025 06:20:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/0Kiq5EXplI6oUv8eH7YNU/f8xh3LwnTj3P6gaOGe3SYNnF3r3jB+Rl6thDerTP4ezuNiwJhkHkqiQrvtJR4=
X-Received: by 2002:a53:b685:0:b0:633:c22b:f0b2 with SMTP id
 956f58d0204a3-63ccb81364bmr5215177d50.7.1760016019212; Thu, 09 Oct 2025
 06:20:19 -0700 (PDT)
MIME-Version: 1.0
From: Luigi Leonardi <leonardi@redhat.com>
Date: Thu, 9 Oct 2025 15:20:08 +0200
X-Gm-Features: AS18NWBP_iOHY0RfweJx15cziK_u7g2sLvPcAvXkHagGdDPnmLU3Wi5ep_Qkzt8
Message-ID: <CANo9s6kqgmSa4w-DkSRDqRw9gw0dBEmaM4yenczA+1uh6ZL9Pw@mail.gmail.com>
Subject: SVSM device assignment: device tree support
To: joro@8bytes.org
Cc: coconut-svsm@lists.linux.dev, qemu-devel@nongnu.org, 
 Stefano Garzarella <sgarzare@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Oliver Steffen <osteffen@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000009fe9280640b9a992"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lleonard@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--0000000000009fe9280640b9a992
Content-Type: text/plain; charset="UTF-8"

Hi Joerg,

I am working on device tree support for SVSM to allow it to discover MMIO
devices that should be used only by SVSM.
In this way we can differentiate the devices attached to VMPL0 and VMPLX.
As we discussed in the SVSM community call,
we can use IGVM to expose the device tree to SVSM. This should be generic
enough to be supported by any hypervisor
(vs the PoC we currently have that uses the fw-cfg).

My idea is to use the IGVM directive "IGVM_VHT_DEVICE_TREE", basically
replicating what was done for MADT,
allocating a page (maybe more?)  for the DT blob, using a new index for the
parameter area.

I think that the DT parameter, just like MADT, should be marked as optional
for now, as not all hypervisors support it.

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

--0000000000009fe9280640b9a992
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_quot=
e"><div dir=3D"ltr"><div dir=3D"ltr"><div>Hi Joerg,</div><div><br></div><di=
v>I am working on device tree support for SVSM to allow it to discover MMIO=
 devices that should be used only by SVSM.</div><div>In this way we can dif=
ferentiate the devices attached to VMPL0 and VMPLX. As we discussed in the =
SVSM community call,</div><div>we can use IGVM to expose the device tree to=
 SVSM. This should be generic enough to be supported by any hypervisor</div=
><div>(vs the PoC we currently have that uses the fw-cfg).=C2=A0</div><br><=
div></div><div>My idea is to use the IGVM directive &quot;IGVM_VHT_DEVICE_T=
REE&quot;, basically replicating what was done for MADT,</div><div>allocati=
ng a page (maybe more?)=C2=A0 for the DT blob, using a new index for the pa=
rameter area.</div><div><br></div><div>I think that the DT parameter, just =
like MADT, should be marked as optional for now, as not all hypervisors sup=
port it.</div><div><br></div><div></div><div>For the QEMU support, I had an=
 offline discussion with Stefano, who suggested creating a new object (for =
example &quot;svsm-devices&quot;)</div><div>where we can specify all the de=
vices that need to be attached to SVSM.</div><div><br></div><div>something =
like=C2=A0this:</div><div><br></div><div>-machine [..] svsm-bus=3Dbus1</div=
><div></div><div>-device virtio-blk-device,drive=3Dsvsm_storage,id=3Ddev1</=
div><div></div><div>-object svsm-devices,id=3Dbus1,devices=3Ddev1,dev2,dev3=
</div><div><br></div><div>This object would be in charge of creating the DT=
.</div><div><br></div><div>Note that we are not sure if it&#39;s doable or =
not, we still need to investigate the best QEMU interface.</div><div><br></=
div><div></div><div>What do you think? Do you have a different idea for the=
 DT support?</div><div><br></div><div>Of course I am very open to suggestio=
ns and comments from everybody.</div><div><br></div><div>Thanks,</div><div>=
Luigi</div></div>
</div>
</div></div>
</div>
</div>

--0000000000009fe9280640b9a992--


