Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3109C25B74
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2024 08:38:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s8Fa1-00082i-7i; Sat, 18 May 2024 04:38:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1s8FZx-00082I-6T
 for qemu-devel@nongnu.org; Sat, 18 May 2024 04:38:09 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1s8FZv-0004U2-6D
 for qemu-devel@nongnu.org; Sat, 18 May 2024 04:38:08 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2e7144055c7so9903871fa.3
 for <qemu-devel@nongnu.org>; Sat, 18 May 2024 01:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716021485; x=1716626285; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k2AZKXeQR69IZmaVTwF0aOwSgZi5kuZng8gYrd3J5IE=;
 b=gwWAAZBpN6h80lcGKXUz2RdprCEJtTVR8VIWwdXLtSKrVTlZD8Uube8MfjDbgWrBfU
 JMweZ/WKoTpi8GIPNddlNWKgrx3KLGDr8J3rp2TXgERAM/m0zKlcDRwa4Tw/LsiQBtoV
 D4IaR4zPZqUGTnXT9ehQIuU6Ylii0Oe7U5LCR2MlQdh4Q9ygb/a3XudmZrbLv9Oy+K3l
 e49XbDM7mc7z5Kznzn/aLX5DBH509sdrmMJEWXJx8IK+Z/7dvp7KZJRZuGbsfprKKJyo
 /WVM7A5xVgOfGsCCFfab2GsyLIL5WBHgqp7UqAJJnyHGy+VW4WNbKa3jA7wYsRTTB9O4
 SxTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716021485; x=1716626285;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k2AZKXeQR69IZmaVTwF0aOwSgZi5kuZng8gYrd3J5IE=;
 b=pWwOoBv9cavyANMg+2qpFIyOqcbBkc8aRN4divQHNqkG2/1aP4lkDYdRAXKHkZQz6G
 ZCbnZKzdvdhrcJWjYUAkewp1zQtJw/SfDH4YkOGGYTKQ9syKZmrRGPstRcW7jnm7AX7J
 pT6iRHXnLp5Bb36nYhcvf7mqHHbjOH6Bf1l+LtFBmLE8gYiBQPAtzV7MnFcGFGmEJkBP
 raqVbr+4Pnw+ez2GFfbH3us5GTqvwwbH2ftyljO7T0VhZNxHGmvqqyoIVqHCZP5yfC6S
 4eCwe61wnEHPSGOijG2N2BmImhiXSWiSNmxqxXz19JbzJD+tQTku9UPEUyf5+gSavRU+
 /zJQ==
X-Gm-Message-State: AOJu0YwWT0kMWdC84yDeWww/C772J80gijF0X5s4d3/KMwXuIi5n+Gra
 agTinsSYuKdwd8kDcngNMTucRYy+8XuBagvlqLKXK3lSJv6XedeaIQG1W9rXhEaY/OdtllvsNDv
 V8E93dvzRCe+HLsMerhKsdNViU3r5O1lN
X-Google-Smtp-Source: AGHT+IGhB1g9UV80adpaMnnZHKLOQIsifKprALuoAOJbNJ9e+nQUg6n4pndA3n+ie2a+rUFkc7eaIjDMm4LuYBgCqqg=
X-Received: by 2002:a2e:4e11:0:b0:2e5:751d:6a8 with SMTP id
 38308e7fff4ca-2e5751d09d3mr113942291fa.42.1716021484729; Sat, 18 May 2024
 01:38:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240518080753.7083-1-dorjoychy111@gmail.com>
In-Reply-To: <20240518080753.7083-1-dorjoychy111@gmail.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Sat, 18 May 2024 14:37:52 +0600
Message-ID: <CAFfO_h7_6QcOaai3Lvi5624mURBFBnSBqt2JZHdxpkY+NW3EkQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] AWS Nitro Enclave emulation support
To: qemu-devel@nongnu.org
Cc: graf@amazon.com, agraf@csgraf.de, stefanha@redhat.com, pbonzini@redhat.com,
 slp@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net, 
 mst@redhat.com, marcel.apfelbaum@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=dorjoychy111@gmail.com; helo=mail-lj1-x22e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi,
I just noticed the reference URL for number [4] in my cover-letter is incor=
rect.

On Sat, May 18, 2024 at 2:08=E2=80=AFPM Dorjoy Chowdhury <dorjoychy111@gmai=
l.com> wrote:
>
> Hi,
>
> Hope everyone is doing well. I am working on adding AWS Nitro Enclave[1]
> emulation support in QEMU. Alexander Graf is mentoring me on this work. T=
his is
> a patch series adding, not yet complete, but useful emulation support of =
nitro
> enclaves. I have a gitlab branch where you can view the patches in the gi=
tlab
> web UI for each commit:
> https://gitlab.com/dorjoy03/qemu/-/tree/nitro-enclave-emulation
>
> AWS nitro enclaves is an Amazon EC2[2] feature that allows creating isola=
ted
> execution environments, called enclaves, from Amazon EC2 instances, which=
 are
> used for processing highly sensitive data. Enclaves have no persistent st=
orage
> and no external networking. The enclave VMs are based on Firecracker micr=
ovm
> and have a vhost-vsock device for communication with the parent EC2 insta=
nce
> that spawned it and a Nitro Secure Module (NSM) device for cryptographic
> attestation. The parent instance VM always has CID 3 while the enclave VM=
 gets
> a dynamic CID. The enclave VMs can communicate with the parent instance o=
ver
> various ports to CID 3, for example, the init process inside an enclave s=
ends a
> heartbeat to port 9000 upon boot, expecting a heartbeat reply, letting th=
e
> parent instance know that the enclave VM has successfully booted.
>
> From inside an EC2 instance, nitro-cli[3] is used to spawn an enclave VM =
using
> an EIF (Enclave Image Format)[4] file. EIF files can be built using nitro=
-cli
> as well. There is no official EIF specification apart from the github
> aws-nitro-enclaves-image-format repository[4]. An EIF file contains the k=
ernel,
> cmdline and ramdisk(s) in different sections which are used to boot the e=
nclave
> VM. You can look at the structs in hw/i386/eif.c file for more details ab=
out
> the EIF file format.
>
> Adding nitro enclave emulation support in QEMU will make the life of AWS =
Nitro
> Enclave users easier as they will be able to test their EIF images locall=
y
> without having to run real nitro enclaves which can be difficult for debu=
gging
> due to its roots in security. This will also make quick prototyping easie=
r.
>
> In QEMU, the new nitro-enclave machine type is implemented based on the m=
icrovm
> machine type similar to how AWS Nitro Enclaves are based on Firecracker m=
icrovm.
> The vhost-vsock device support is already part of this patch series so th=
at the
> enclave VM can communicate to CID 3 using vsock. A mandatory 'guest-cid'
> machine type option is needed which becomes the CID of the enclave VM. So=
me
> documentation for the new 'nitro-enclave' machine type has also been adde=
d. The
> NSM device support will be added in the future.
>
> The plan is to eventually make the nitro enclave emulation in QEMU standa=
lone
> i.e., without needing to run another VM with CID 3 with proper vsock
> communication support. For this to work, one approach could be to teach t=
he
> vhost-vsock driver in kernel to forward CID 3 messages to another CID
> (set to CID 2 for host) so that users of the nitro-enclave machine type c=
an
> run the necessary vsock server/clients in the host machine (some defaults=
 can
> be implemented in QEMU as well, for example, sending a reply to the heart=
beat)
> which will rid them of the cumbersome way of running another whole VM wit=
h CID
> 3. This way, users of nitro-enclave machine in QEMU, could potentially al=
so run
> multiple enclaves with their messages for CID 3 forwarded to different CI=
Ds
> which, in QEMU side, could then be specified using a new machine type opt=
ion
> (parent-cid) if implemented. I will be posting an email to the linux
> virtualization mailing list about this approach asking for feedback and
> suggestions soon.
>
> For local testing you need to generate a hello.eif image by first buildin=
g
> nitro-cli locally[5]. Then you can use nitro-cli to build a hello.eif ima=
ge[6].
>
> You need to build qemu-system-x86_64 after applying the patches and then =
you
> can run the following command to boot a hello.eif image using the new
> 'nitro-enclave' machine type option in QEMU:
>
> sudo ./qemu-system-x86_64 -M nitro-enclave,guest-cid=3D8 -kernel path/to/=
hello.eif -nographic -m 4G --enable-kvm -cpu host
>
> The command needs to be run as sudo because for the vhost-vsock device to=
 work
> QEMU needs to be able to open vhost device in host.
>
> Right now, if you just run the nitro-enclave machine, the kernel panics b=
ecause
> the init process exits abnormally because it cannot connect to port 9000 =
to CID
> 3 to send its heartbeat message (the connection times out), so another VM=
 with
> CID 3 with proper vsock communication support must be run for it to be us=
eful.
> But this restriction can be lifted once the approach about forwarding CID=
 3
> messages is implemented if it gets accepted.
>
> Thanks.
>
> Regards,
> Dorjoy
>
> [1] https://docs.aws.amazon.com/enclaves/latest/user/nitro-enclave.html
> [2] https://aws.amazon.com/ec2/
> [3] https://docs.aws.amazon.com/enclaves/latest/user/getting-started.html
> [4] https://docs.aws.amazon.com/enclaves/latest/user/getting-started.html

It should be this instead:
[4] https://github.com/aws/aws-nitro-enclaves-image-format

Sorry about that.

Regards,
Dorjoy

