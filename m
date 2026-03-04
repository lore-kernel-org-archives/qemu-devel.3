Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4066CEB7EAC
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 09:19:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxiNH-0003eh-N9; Wed, 04 Mar 2026 04:18:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <demiobenour@gmail.com>)
 id 1vxiN9-0003bZ-2W
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 04:18:28 -0500
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <demiobenour@gmail.com>)
 id 1vxiN6-0001D7-LM
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 04:18:26 -0500
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-7947cf097c1so63394697b3.2
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 01:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772615903; x=1773220703; darn=nongnu.org;
 h=in-reply-to:autocrypt:from:content-language:references:cc:to
 :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=OhzGWkWrsQTCRYwVQ4NY2VnSVbdbUEZodXHW3cH10pU=;
 b=U/r8xE0IsZq1kI8lDMaLBb/NO++qayqGM0SxGHXWfzMQGWVsDQ0zk1yStoghlTwYzc
 /ET+JUMr6J40VZmmdnHC7qvKU2KZfXjdhqAV6g6ewyKiTrNM9T8K3cy245fzP+YfOPbp
 rRvReZ1A0aZILWFkT6fNU8wbc8sBo13SSRLhKC6GuTdnTKQCXd4+KQ3EGFGNyK0Utq2M
 6Vc1Y3GTgG3NdvN+UDEFpVGa+VY/w0+Acmm5WRhnyJX7kS3Xi7iElYQyDLDNc/th4CSN
 hb+KEm9HKqe285il6W+5eqZFt3B7TBqWp+CttCl2pWlhkwb14fwm59Ca9E2lMjZinwVw
 ahZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772615903; x=1773220703;
 h=in-reply-to:autocrypt:from:content-language:references:cc:to
 :subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OhzGWkWrsQTCRYwVQ4NY2VnSVbdbUEZodXHW3cH10pU=;
 b=IYEscde/f/sEfBpP6ZKCaYH2nFCTg4HrSYsvTQacKAzIJ1hEo4y8lBL5d0fc26n4jv
 cCdg5b15o3kj4gEIblBYL/mYhaMY+tCNsv9Y/OSpZJZJ2QhCGNz9X+9eTKuaP5bjTe50
 oVt2yFLVvaG3yHiVvo9qefbtZqyGTbm7WoRcTSZOmqD1KyMkxmb913Ur9dQaCO0bBhXl
 wu4y+cWhSLGt8su0X94X+N5LBABOxt3zSiv159F3DxBwwGLKda8Q0F9ddveWf/x+Wvwb
 YA6KnWPoJQFB+vsCmSipNfQ0o2wxzkp9m0o51vQlygVR/8UWV4gLo56YR7B5MIkVrmG7
 M2PQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTXjDpJBt89dp8I9IVmIl/H/UoPwe95016rtRR0spdKPFcGtj1VNW6vnN23SQagPFopkTO4i23WMou@nongnu.org
X-Gm-Message-State: AOJu0Yxd6seBF3KBFhMWRYDGV52lZLFXcx4eso0cI0rHlXCXCM6oUbSW
 tlPdUCI5PKaqRvl8PzOaZvwOFW4jtJLIrJ6/UAX0rON1kTaCJdNHqaaT
X-Gm-Gg: ATEYQzyxgDcfTPyuGvwy1FpEb8tJuwwcHBdhmf59+yWqKGFIbPIs5xSTCbKxxiherx9
 xd2/6nm6pbrQCTMfKaUaqKnZYbd0mef8Fj7IjO3YHc2XkGFKF2KHbJUHY3BOxsMSlqIsAd1Ro9j
 hHU8rg+nLcH7C1thHZUeNf56T9rwWeu0oCVziccja0mqZS8bkPOuptX5RKDDX5M/U3rleofpRrH
 Hc11SkppAsr4pipsiQ+aw80lEDSNYe9P2VEB93VSc5jO9sAslGy9AV0kKH9j5Jj/k+ZuXJ/EMp+
 IN1N+LT6UncbgSqGxoG/MIg8l11MJ/l+aRuM9l8FLaXLEn4uJgAk3Q+LeJjS5FstDku2jO6QSlG
 RErG6V2hKd/K2z2s98o4VuZgV8BhECd2QPK6z+uQj9JOC9WQnBecBx0vPQZFBAYybERXLeIBsbr
 HZfySdM5Xqgeuvs0w6XtobqfTyDjj/flNV70d3ds47oPq6gSnkJCsUdpV/DIjRrw3yvjUiBS6ET
 NBorlShG5ld8QW7Eu3H0mLyVkrOpC04slbo7hY=
X-Received: by 2002:a05:690c:67c6:b0:798:4d34:cc36 with SMTP id
 00721157ae682-798c6c880ebmr11037017b3.35.1772615903171; 
 Wed, 04 Mar 2026 01:18:23 -0800 (PST)
Received: from [10.138.34.110]
 (h69-131-217-18.cncrtn.broadband.dynamic.tds.net. [69.131.217.18])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-798c256f6dcsm10621827b3.29.2026.03.04.01.18.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Mar 2026 01:18:21 -0800 (PST)
Message-ID: <c0e4f57e-4803-4908-88fb-0258199edeb6@gmail.com>
Date: Wed, 4 Mar 2026 04:18:16 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: virtio-msg inter-VM transport vs virtio-vhost-user
To: Bertrand Marquis <Bertrand.Marquis@arm.com>
Cc: Alyssa Ross <hi@alyssa.is>, Bo Chen <bchen@crusoe.ai>,
 Rob Bradford <rbradford@meta.com>, Wei Liu <liuwe@microsoft.com>,
 Sebastien Boeuf <seb@rivosinc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "dev@lists.cloudhypervisor.org" <dev@lists.cloudhypervisor.org>,
 Spectrum OS Development <devel@spectrum-os.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 "virtio-comment@lists.linux.dev" <virtio-comment@lists.linux.dev>
References: <b291c8af-58ee-46e4-9033-e681ff9677db@gmail.com>
 <08706B81-11D1-47DA-BC0B-756CF3705C69@arm.com>
Content-Language: en-US
From: Demi Marie Obenour <demiobenour@gmail.com>
Autocrypt: addr=demiobenour@gmail.com; keydata=
 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
 +MYSfkEjBz0E8CLOcAw7JIwAaeBT
In-Reply-To: <08706B81-11D1-47DA-BC0B-756CF3705C69@arm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------fyJZ4HNxCijSIRcjCe2jlU5S"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=demiobenour@gmail.com; helo=mail-yw1-x1131.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------fyJZ4HNxCijSIRcjCe2jlU5S
Content-Type: multipart/mixed; boundary="------------0sXAaGY505d4uoImswr0A905";
 protected-headers="v1"
Message-ID: <c0e4f57e-4803-4908-88fb-0258199edeb6@gmail.com>
Date: Wed, 4 Mar 2026 04:18:16 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: virtio-msg inter-VM transport vs virtio-vhost-user
To: Bertrand Marquis <Bertrand.Marquis@arm.com>
Cc: Alyssa Ross <hi@alyssa.is>, Bo Chen <bchen@crusoe.ai>,
 Rob Bradford <rbradford@meta.com>, Wei Liu <liuwe@microsoft.com>,
 Sebastien Boeuf <seb@rivosinc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "dev@lists.cloudhypervisor.org" <dev@lists.cloudhypervisor.org>,
 Spectrum OS Development <devel@spectrum-os.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 "virtio-comment@lists.linux.dev" <virtio-comment@lists.linux.dev>
References: <b291c8af-58ee-46e4-9033-e681ff9677db@gmail.com>
 <08706B81-11D1-47DA-BC0B-756CF3705C69@arm.com>
Content-Language: en-US
From: Demi Marie Obenour <demiobenour@gmail.com>
Autocrypt: addr=demiobenour@gmail.com; keydata=
 xsFNBFp+A0oBEADffj6anl9/BHhUSxGTICeVl2tob7hPDdhHNgPR4C8xlYt5q49yB+l2nipd
 aq+4Gk6FZfqC825TKl7eRpUjMriwle4r3R0ydSIGcy4M6eb0IcxmuPYfbWpr/si88QKgyGSV
 Z7GeNW1UnzTdhYHuFlk8dBSmB1fzhEYEk0RcJqg4AKoq6/3/UorR+FaSuVwT7rqzGrTlscnT
 DlPWgRzrQ3jssesI7sZLm82E3pJSgaUoCdCOlL7MMPCJwI8JpPlBedRpe9tfVyfu3euTPLPx
 wcV3L/cfWPGSL4PofBtB8NUU6QwYiQ9Hzx4xOyn67zW73/G0Q2vPPRst8LBDqlxLjbtx/WLR
 6h3nBc3eyuZ+q62HS1pJ5EvUT1vjyJ1ySrqtUXWQ4XlZyoEFUfpJxJoN0A9HCxmHGVckzTRl
 5FMWo8TCniHynNXsBtDQbabt7aNEOaAJdE7to0AH3T/Bvwzcp0ZJtBk0EM6YeMLtotUut7h2
 Bkg1b//r6bTBswMBXVJ5H44Qf0+eKeUg7whSC9qpYOzzrm7+0r9F5u3qF8ZTx55TJc2g656C
 9a1P1MYVysLvkLvS4H+crmxA/i08Tc1h+x9RRvqba4lSzZ6/Tmt60DPM5Sc4R0nSm9BBff0N
 m0bSNRS8InXdO1Aq3362QKX2NOwcL5YaStwODNyZUqF7izjK4QARAQABzTxEZW1pIE1hcmll
 IE9iZW5vdXIgKGxvdmVyIG9mIGNvZGluZykgPGRlbWlvYmVub3VyQGdtYWlsLmNvbT7CwXgE
 EwECACIFAlp+A0oCGwMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAAAoJELKItV//nCLBhr8Q
 AK/xrb4wyi71xII2hkFBpT59ObLN+32FQT7R3lbZRjVFjc6yMUjOb1H/hJVxx+yo5gsSj5LS
 9AwggioUSrcUKldfA/PKKai2mzTlUDxTcF3vKx6iMXKA6AqwAw4B57ZEJoMM6egm57TV19kz
 PMc879NV2nc6+elaKl+/kbVeD3qvBuEwsTe2Do3HAAdrfUG/j9erwIk6gha/Hp9yZlCnPTX+
 VK+xifQqt8RtMqS5R/S8z0msJMI/ajNU03kFjOpqrYziv6OZLJ5cuKb3bZU5aoaRQRDzkFIR
 6aqtFLTohTo20QywXwRa39uFaOT/0YMpNyel0kdOszFOykTEGI2u+kja35g9TkH90kkBTG+a
 EWttIht0Hy6YFmwjcAxisSakBuHnHuMSOiyRQLu43ej2+mDWgItLZ48Mu0C3IG1seeQDjEYP
 tqvyZ6bGkf2Vj+L6wLoLLIhRZxQOedqArIk/Sb2SzQYuxN44IDRt+3ZcDqsPppoKcxSyd1Ny
 2tpvjYJXlfKmOYLhTWs8nwlAlSHX/c/jz/ywwf7eSvGknToo1Y0VpRtoxMaKW1nvH0OeCSVJ
 itfRP7YbiRVc2aNqWPCSgtqHAuVraBRbAFLKh9d2rKFB3BmynTUpc1BQLJP8+D5oNyb8Ts4x
 Xd3iV/uD8JLGJfYZIR7oGWFLP4uZ3tkneDfYzsFNBFp+A0oBEAC9ynZI9LU+uJkMeEJeJyQ/
 8VFkCJQPQZEsIGzOTlPnwvVna0AS86n2Z+rK7R/usYs5iJCZ55/JISWd8xD57ue0eB47bcJv
 VqGlObI2DEG8TwaW0O0duRhDgzMEL4t1KdRAepIESBEA/iPpI4gfUbVEIEQuqdqQyO4GAe+M
 kD0Hy5JH/0qgFmbaSegNTdQg5iqYjRZ3ttiswalql1/iSyv1WYeC1OAs+2BLOAT2NEggSiVO
 txEfgewsQtCWi8H1SoirakIfo45Hz0tk/Ad9ZWh2PvOGt97Ka85o4TLJxgJJqGEnqcFUZnJJ
 riwoaRIS8N2C8/nEM53jb1sH0gYddMU3QxY7dYNLIUrRKQeNkF30dK7V6JRH7pleRlf+wQcN
 fRAIUrNlatj9TxwivQrKnC9aIFFHEy/0mAgtrQShcMRmMgVlRoOA5B8RTulRLCmkafvwuhs6
 dCxN0GNAORIVVFxjx9Vn7OqYPgwiofZ6SbEl0hgPyWBQvE85klFLZLoj7p+joDY1XNQztmfA
 rnJ9x+YV4igjWImINAZSlmEcYtd+xy3Li/8oeYDAqrsnrOjb+WvGhCykJk4urBog2LNtcyCj
 kTs7F+WeXGUo0NDhbd3Z6AyFfqeF7uJ3D5hlpX2nI9no/ugPrrTVoVZAgrrnNz0iZG2DVx46
 x913pVKHl5mlYQARAQABwsFfBBgBAgAJBQJafgNKAhsMAAoJELKItV//nCLBwNIP/AiIHE8b
 oIqReFQyaMzxq6lE4YZCZNj65B/nkDOvodSiwfwjjVVE2V3iEzxMHbgyTCGA67+Bo/d5aQGj
 gn0TPtsGzelyQHipaUzEyrsceUGWYoKXYyVWKEfyh0cDfnd9diAm3VeNqchtcMpoehETH8fr
 RHnJdBcjf112PzQSdKC6kqU0Q196c4Vp5HDOQfNiDnTf7gZSj0BraHOByy9LEDCLhQiCmr+2
 E0rW4tBtDAn2HkT9uf32ZGqJCn1O+2uVfFhGu6vPE5qkqrbSE8TG+03H8ecU2q50zgHWPdHM
 OBvy3EhzfAh2VmOSTcRK+tSUe/u3wdLRDPwv/DTzGI36Kgky9MsDC5gpIwNbOJP2G/q1wT1o
 Gkw4IXfWv2ufWiXqJ+k7HEi2N1sree7Dy9KBCqb+ca1vFhYPDJfhP75I/VnzHVssZ/rYZ9+5
 1yDoUABoNdJNSGUYl+Yh9Pw9pE3Kt4EFzUlFZWbE4xKL/NPno+z4J9aWemLLszcYz/u3XnbO
 vUSQHSrmfOzX3cV4yfmjM5lewgSstoxGyTx2M8enslgdXhPthZlDnTnOT+C+OTsh8+m5tos8
 HQjaPM01MKBiAqdPgksm1wu2DrrwUi6ChRVTUBcj6+/9IJ81H2P2gJk3Ls3AVIxIffLoY34E
 +MYSfkEjBz0E8CLOcAw7JIwAaeBT
In-Reply-To: <08706B81-11D1-47DA-BC0B-756CF3705C69@arm.com>
Autocrypt-Gossip: addr=hi@alyssa.is; keydata=
 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
 9KKY1Fh8LBKH

--------------0sXAaGY505d4uoImswr0A905
Content-Type: multipart/mixed; boundary="------------tcsakpxA0MpCzbRHyvgyy5gs"

--------------tcsakpxA0MpCzbRHyvgyy5gs
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 3/4/26 03:26, Bertrand Marquis wrote:
> Hi Demi,
>=20
>> On 3 Mar 2026, at 18:56, Demi Marie Obenour <demiobenour@gmail.com> wr=
ote:
>>
>> Spectrum (https://spectrum-os.org) is going to be implementing
>> virtio devices outside of the host.  One proposed method of doing
>> this is virtio-vhost-user, which is a virtio device that allows a
>> VM to expose a vhost-user device to another VM.  For instance, one
>> could assign a NIC to one VM and have it provide a vhost-user-net
>> device for use by a different VM.
>>
>> I brought this up on the KVM/QEMU community call today.  Alex Benn=C3=A9=
e
>> recommended using virtio-msg instead.  However, I have a few concerns
>> with this:
>>
>> 1. Virtio-msg buses are specific to a given hypervisor or (in the
>>   case of FF-A) to a given CPU architecture.  None of the current
>>   buses support KVM on platforms other than Arm64.  Therefore,
>>   a brand-new bus would be needed.
>=20
> Even FF-A is not useable at the moment with KVM as there is no FF-A
> support for VM to VM in KVM (only host can communicate with the secure
> world).

Ah, I thought that pKVM had pVM <=3D> pVM communication implemented.

> MMIO or PCI based virtio in KVM case is working and was not really
> the target of our work.
>=20
> pKVM is a target and is being worked on using FF-A but pVM to Host
> virtio is still using PCI at the moment

Makes sense.  Does that involve any confidential computing-specific
code in the PCI subsystem, or has the subsystem as a whole been
hardened against malicious devices?  That matters for some of my
use-cases, where a device may be present but not authorized for use.
It's supposed to be passed through to a VM.

> Now creating a KVM specific bus reusing the concept of a FIFO
> to transfer the messages between a VM and Host is definitely possible
> to do and should not be that complex.

Can you give a rough estimate of how much code you are referring to?

> Right now i am working on backend implementation where:
> - the bus implementation would be in linux kernel allowing several
> implementations like FF-A, xen or others to be done as linux drivers.

What is the advantage of having the bus implementation in the kernel
as opposed to userspace?  Is it because the bus implementation is
responsible for protecting the kernel from malicious userspace?

In case you can't tell already, I'm a fan of microkernels :).

> - have a bus interface provided to user land so that Qemu could contain=

> the transport implementation but would not need to be modified for new
> bus implementations.
>=20
> Reusing this, it should be fairly simple to define a KVM bus and reuse
> the other parts of the implementations.

How long do you think it will be before this could be included in
upstream, mainline Linux?  I imagine this would need to wait for your
existing virtio-msg work to be upstreamed, and then I would need to
upstream a separate driver and spec.

>> 2. Virtio-msg requires not-yet-upstream drivers in both the frontend
>>   (the VM using the device) and the backend (the VM providing the
>>   device).  Vhost-user uses any of the existing transports, such as
>>   PCI or MMIO.  This means that upstream drivers can be used in the
>>   frontend, and also enables supports for Windows and other guests
>>   that lack support for virtio-msg.
>=20
> This is definitely true and will always stay true. To use virtio-msg yo=
u
> will need a new transport implementation for it when you want to use
> it and the bus implementation(s) you require. To be used in windows
> those part will also be needed.
>=20
> In your example here you rely on existing MMIO or PCI transport and
> existing vhost implementations. This is definitely quicker to do and us=
e.
> The goal is not replace what works but to provide solutions for use cas=
es
> where MMIO or PCI currently do not work or need to be optimized.

My use-case doesn't have the same restrictions, as long as config
space access is rare and denial of service is not a concern.

>> 3. Vhost-user is already widely deployed, so frontend implementations
>>   are quite well tested.  A KVM-specific virtio-msg transport would
>>   serve only one purpose: driver VMs (with assigned devices) on
>>   non-Arm64 platforms.  This is a quite niche use-case.  Therefore,
>>   I'm concerned that the needed frontend code will be poorly tested
>>   and bitrot.
>=20
> We are in the process of defining the specification for virtio-msg and =
we
> are working on implementations in parallel so our implementations are
> for now not widely tested that is clear.
> Now a specific KVM virtio message bus implementation would reuse
> the transport and driver implementations which would be used on any
> platforms in the future. I am not following your niche use-case here
> and the poorly tested argument. Maybe i am missing something.
>=20
>>
>> Manos Pitsidianakis stated that vhost-user does not make sense in
>> this case.  Why is that?  Would it make sense to use virtio-msg
>> between VMM and its VM, and expose a vhost-user device to the
>> outside world?  What about having the virtio-vhost-user guest driver
>> emulate a virtio-msg transport, so that it can be used with any device=

>> implementation supporting virtio-msg?
>=20
> I am not following your point here. You want to do virtio on top of vir=
tio ?

Yes, actually!  More specifically, I want to use a virtio device in
one VM to implement a virtio device for a different VM.

To avoid confusion, and to match Xen terminology, I'll call the
userspace VMM that acts as a vhost-user server the *backend* VMM.
The *frontend* VMM is the one that acts as a vhost-user client, and is
completely unaware that anything special is happening in the backend.

A virtio vhost-user device is a virtio device that acts as a vhost-user
server.  For each vhost-user device it wants its guest to implement,
a VMM listens on a AF_UNIX socket, just like any other userspace
process would.  It then creates a virtio device in this guest, with
type *vhost-user device backend*.  This device has a single virtqueue,
and vhost-user messages are forwarded between that virtqueue and the
AF_UNIX socket.

The backend VMM needs to handle ancillary data specially.
For instance, memory that it mmap's is placed in a PCI BAR that is
accessible to the guest, much like a virtio-GPU blob object.  Vring
kick file descriptors are registered with the kernel as irqfds, so
when the frontend signals them, the backend VM receives an interrupt.
Vring call, error, and log file descriptors are registered with the
kernel as ioeventfds, so that the backend VM can trigger them by
MMIO writes.  It also registers and unregisters irqfds in response
to interrupts being unmasked and masked.

After everything has been set up, the backend VMM is *not* involved in
performance-critical operations.  The vhost-user shared memory regions
are mapped into its address space, so it can access them just like any
other memory.  Writing to an ioeventfd in the frontend VM causes KVM to
trigger an interrupt in the backend VM and visa versa.  I expect that
performance should be almost as good as a vhost-user device implemented
in userspace, but with the full isolation guarantees of a VM.

https://stefanha.github.io/virtio/vhost-user-slave.html has the spec
I am currently using.  It does a much better job explaining things.
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
--------------tcsakpxA0MpCzbRHyvgyy5gs
Content-Type: application/pgp-keys; name="OpenPGP_0xB288B55FFF9C22C1.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB288B55FFF9C22C1.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsFNBFp+A0oBEADffj6anl9/BHhUSxGTICeVl2tob7hPDdhHNgPR4C8xlYt5q49y
B+l2nipdaq+4Gk6FZfqC825TKl7eRpUjMriwle4r3R0ydSIGcy4M6eb0IcxmuPYf
bWpr/si88QKgyGSVZ7GeNW1UnzTdhYHuFlk8dBSmB1fzhEYEk0RcJqg4AKoq6/3/
UorR+FaSuVwT7rqzGrTlscnTDlPWgRzrQ3jssesI7sZLm82E3pJSgaUoCdCOlL7M
MPCJwI8JpPlBedRpe9tfVyfu3euTPLPxwcV3L/cfWPGSL4PofBtB8NUU6QwYiQ9H
zx4xOyn67zW73/G0Q2vPPRst8LBDqlxLjbtx/WLR6h3nBc3eyuZ+q62HS1pJ5EvU
T1vjyJ1ySrqtUXWQ4XlZyoEFUfpJxJoN0A9HCxmHGVckzTRl5FMWo8TCniHynNXs
BtDQbabt7aNEOaAJdE7to0AH3T/Bvwzcp0ZJtBk0EM6YeMLtotUut7h2Bkg1b//r
6bTBswMBXVJ5H44Qf0+eKeUg7whSC9qpYOzzrm7+0r9F5u3qF8ZTx55TJc2g656C
9a1P1MYVysLvkLvS4H+crmxA/i08Tc1h+x9RRvqba4lSzZ6/Tmt60DPM5Sc4R0nS
m9BBff0Nm0bSNRS8InXdO1Aq3362QKX2NOwcL5YaStwODNyZUqF7izjK4QARAQAB
zTxEZW1pIE9iZW5vdXIgKElUTCBFbWFpbCBLZXkpIDxhdGhlbmFAaW52aXNpYmxl
dGhpbmdzbGFiLmNvbT7CwY4EEwEIADgWIQR2h02fEza6IlkHHHGyiLVf/5wiwQUC
X6YJvQIbAwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgAAKCRCyiLVf/5wiwWRhD/0Y
R+YYC5Kduv/2LBgQJIygMsFiRHbR4+tWXuTFqgrxxFSlMktZ6gQrQCWe38WnOXkB
oY6n/5lSJdfnuGd2UagZ/9dkaGMUkqt+5WshLFly4BnP7pSsWReKgMP7etRTwn3S
zk1OwFx2lzY1EnnconPLfPBc6rWG2moA6l0WX+3WNR1B1ndqpl2hPSjT2jUCBWDV
rGOUSX7r5f1WgtBeNYnEXPBCUUM51pFGESmfHIXQrqFDA7nBNiIVFDJTmQzuEqIy
Jl67pKNgooij5mKzRhFKHfjLRAH4mmWZlB9UjDStAfFBAoDFHwd1HL5VQCNQdqEc
/9lZDApqWuCPadZN+pGouqLysesIYsNxUhJ7dtWOWHl0vs7/3qkWmWun/2uOJMQh
ra2u8nA9g91FbOobWqjrDd6x3ZJoGQf4zLqjmn/P514gb697788e573WN/MpQ5XI
Fl7aM2d6/GJiq6LC9T2gSUW4rbPBiqOCeiUx7Kd/sVm41p9TOA7fEG4bYddCfDsN
xaQJH6VRK3NOuBUGeL+iQEVF5Xs6Yp+U+jwvv2M5Lel3EqAYo5xXTx4ls0xaxDCu
fudcAh8CMMqx3fguSb7Mi31WlnZpk0fDuWQVNKyDP7lYpwc4nCCGNKCj622ZSocH
AcQmX28L8pJdLYacv9pU3jPy4fHcQYvmTavTqowGnM08RGVtaSBNYXJpZSBPYmVu
b3VyIChsb3ZlciBvZiBjb2RpbmcpIDxkZW1pb2Jlbm91ckBnbWFpbC5jb20+wsF4
BBMBAgAiBQJafgNKAhsDBgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRCyiLVf
/5wiwYa/EACv8a2+MMou9cSCNoZBQaU+fTmyzft9hUE+0d5W2UY1RY3OsjFIzm9R
/4SVccfsqOYLEo+S0vQMIIIqFEq3FCpXXwPzyimotps05VA8U3Bd7yseojFygOgK
sAMOAee2RCaDDOnoJue01dfZMzzHPO/TVdp3OvnpWipfv5G1Xg96rwbhMLE3tg6N
xwAHa31Bv4/Xq8CJOoIWvx6fcmZQpz01/lSvsYn0KrfEbTKkuUf0vM9JrCTCP2oz
VNN5BYzqaq2M4r+jmSyeXLim922VOWqGkUEQ85BSEemqrRS06IU6NtEMsF8EWt/b
hWjk/9GDKTcnpdJHTrMxTspExBiNrvpI2t+YPU5B/dJJAUxvmhFrbSIbdB8umBZs
I3AMYrEmpAbh5x7jEjoskUC7uN3o9vpg1oCLS2ePDLtAtyBtbHnkA4xGD7ar8mem
xpH9lY/i+sC6CyyIUWcUDnnagKyJP0m9ks0GLsTeOCA0bft2XA6rD6aaCnMUsndT
ctrab42CV5XypjmC4U1rPJ8JQJUh1/3P48/8sMH+3krxpJ06KNWNFaUbaMTGiltZ
7x9DngklSYrX0T+2G4kVXNmjaljwkoLahwLla2gUWwBSyofXdqyhQdwZsp01KXNQ
UCyT/Pg+aDcm/E7OMV3d4lf7g/CSxiX2GSEe6BlhSz+Lmd7ZJ3g32M1ARGVtaSBN
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
EtJuZYM5blWncBOJCoWMnBEcTEo/viU3GgcVRw=3D=3D
=3Dx94R
-----END PGP PUBLIC KEY BLOCK-----

--------------tcsakpxA0MpCzbRHyvgyy5gs--

--------------0sXAaGY505d4uoImswr0A905--

--------------fyJZ4HNxCijSIRcjCe2jlU5S
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEopQtqVJW1aeuo9/sszaHOrMp8lMFAmmn+NgACgkQszaHOrMp
8lOCtg//R/dfOFLPkjZ2VpNIUEdUcl+5duWAGDqAguabRzoKD6JR+XmtZ0xVdw5s
vW57+M6d4mQBCYaQpfifMoUx14dewbc4jFgRkmI//guL5pB4S1nWrdqt9hcLv4E8
pGGuklT/LnLh3Ojf3Sb/dCqQqC5zv2cSYzQv7LDLEPn3f167W4qGc4GiW/NcRg6K
DfUdUCH+DVYuEteVl0gnqNPZeDE9Lz/MxgHoQ+Nro04cok0v3Pq3oPJ3RR6Uwr8R
Xz8iCEmkMPxUCL7seSKMboFXQdRtPS2DnQMvfJc5jv4zkGkJ1A3MB+wJReer1YNj
x+IMfHhQpaS7iMgL6o+wwyCtc/IXg4vIatamu8BSUZESmnqI01V4WEP45lsu2mr9
TTe2fE5Nee4mrQbfvRotpO6CpRPA5lePVOGNtl3RbLV1mbJG2xmTDXCE/90GBdwi
FL7MbfEHuJLFiHai+llROag4hs01EaAn00DJ1GB17uDgQixV14yCEMBVs5GfFkry
+ASjlRRTWzJDDI736IyYd1n88rc3819uPtXiPKjphc64cKCd1poFfN1/a5TS62vf
fAXWjE+Vx+CKFgOP6lAAC+e7O0LHKqJcXXqBEyafPs/WeeQyhva+c4gxi07YuFhQ
ijgm3qBTTglD4PcqG+N1ceYGobG81ZG1P3SQ4S2XYSrRa29Bnkk=
=Jwpy
-----END PGP SIGNATURE-----

--------------fyJZ4HNxCijSIRcjCe2jlU5S--

