Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 114D4C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 10:42:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rza4X-0001pb-MZ; Wed, 24 Apr 2024 06:41:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pjp@fedoraproject.org>)
 id 1rza4V-0001p4-AG
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 06:41:51 -0400
Received: from sonic312-19.consmr.mail.sg3.yahoo.com ([106.10.244.209])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pjp@fedoraproject.org>)
 id 1rza4S-0007j1-Pw
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 06:41:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1713955290; bh=ZHUvPf6x9dzkrjde/3+5mJAgiMDJMxVS/+99VE6c2yY=;
 h=Date:From:Reply-To:To:Cc:In-Reply-To:References:Subject:From:Subject:Reply-To;
 b=SaAjN6QNH/fSe/eG+XFpfjPtnA3kYd3wNtlHJYUzSrLGvsiE08PxN5hf23dGO4LzUdOdTnYe2kvETvYfQ4XoQRJRj0lVxCCwbkdcngHE9YJH98ohcPUmG+Ews3Wi98Eob60J2ZdcF0EB0j357NxOW7T++DLjAlm3PrWA4hTVt3gSjDcBg7GuKGpuQJGUALuU/sHetxssxVbiib7WOUS8Rla+dZ6V7t9ITdcLfmM4NIS8iT7DRB4hcnB2CQs0whlLsuCTqc/NQhxzXvn5tby43teTBIa0h2amAz6QgDysj7tkb1005yXE5YV7lqYPc5SIhky/Q1fDkHkZMw4Ic8x4jQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1713955290; bh=kg9KoxasYPEFNCD0paJmxltZuTvH+uv4g6Lr0o59dcp=;
 h=X-Sonic-MF:Date:From:To:Subject:From:Subject;
 b=nejTjaLVkHAGS9kCRp+tLM2R/TrGvAp9FMQ0sitBQLguhyCLvZf+cFoosFY8OEeaa1MQvjViMKJC4V8dn6b9bMy7wFJrTxXn7VjsUJRTBwR6h/r+czP+2NfXWzaTehE3jJeo5+CXvVDVsijTrN/NDV65u/27YVPz5vBmsNWu1QtKUtYH/EW2dSLXXtmjTIfySlKE9AlYWnvF7/33v7APX5inQqzx9jDEScBCg0yExBlx+JOVBZ5YLuqhTUcYQnd97Dps5iOvy+tUQgIeymh3Qg+8jntSIH1vCRZCG19EqNtAMEfohJv91SdG94x89dEZzwfjkBB4nTJlboaCi8zXNw==
X-YMail-OSG: RzG42BQVM1kkuzeaNYR0Yh6VS0p6dHqZwNmrfDpOtjjQ5iB8lyeyd7Ki9oO9eyG
 SPu..wufyX7_qkglontsh0stzWLY6VC3QlUD_tRHb1Hs4TJD_R9RNHwR3RTAPw9HzMKzFsqoD82y
 gMkDXeq79.CEamoVQ5edEZEqsWAwF9fuhMnrq0oUPTTLPoNa1YHtJGx.2CB4Kmy.HEju5z9ObdMU
 G2NSZsgGsTRBDR.oyo8FnezSGSjagJqFsh_N.mjd7fnK91D0MNYpopEilAt9nrC.9sjTHcNOWOVO
 MyXO4fSPtzPg7WXtxNDq4V9LoBs2I_YbFvniwSLuceQePXepvneoMLZmBi3q4TF6zH2RlunSxZdz
 79xHzCY.5Qx27esq39A7tYW8sX_MdcjhQBKx6b0C6JqRCABuPand16_bEgJRRvbuYgnYtfhiThZx
 fHmLuwCEhr7sm5JxhcVxV2wlwO6q.loORBTwNrMz6g3cUTFq255L7mfZ5oyPVBoGYK8HF779kb1r
 Ipno8pA6OSH796YVNd_0ErH1krteIJrmkhs5zZeWJjMgdL_Es0kjssMDgahPZf4h8uczEpfYpByo
 7nzYoMCGrEGLPkBS4K6Rnf56839JbGdNRTesozLQze22ok5.1OWb.PZsWOVoiUpJDdnruIjfJ6XR
 iU2GLxwwgZbnacprLrCCNpN9uawaQegDE4Bxfc2h.kT5ezMSTfCU6UfdvYTe4qPyb_QJnro4CF_v
 r2SE87Fo3tbhYhDn__DNBg2GGdX1hIWrFYIcTcIgY.JTObMoF_NqRdO02UqIslR5LqwFduaLcymm
 fKht4fCRtj5pyVoLjufLdkzLQ.J_X0vvF6Cj6gLmgBvlIfbIqbcU6LOkWMOzEcnsAvZdli4e1uTx
 Vcj1oY45DYEhhs12Xw2yLqDxqYUEy4dgnigTVQXVlZdXViyqqFbHS7NOkd1SZ3IGP6HJx6wBuJPF
 mJltsm2Rez6l179mNg5roR6cinpMRFsn.IekVF3TmVMytn49Lr8dx1JJR9YSb2Xm9iZkS9vgVPUd
 zkuOm81Yl0S2PU8UVmkKDF96245ujaSu1V6rQhjPtqoM8NzZfgORWBjgRrPZ6UgEGVcm7ihOxuKY
 F1cxMqb9WqwHo3TwIzrWLz.EzfwlpLrGjv4NEbQOhi4GaJRqZOMstXq4_c9tdqo2J9dYewNuONNZ
 x.PzgxL8HYixeYmZWw5R458Q.Y58CbtgWHZ7MgAL8m9wmIgPHf6NokWgH5jAuNCFH8AD3aDOUtOK
 09AZI0DpZWf4rsRLmdn7nIrXwS5DTB1Z01N9AHGO1wuA1SAB7u5wLp3UERNfpaZKiGAsd6J3PnYR
 6Slk6Jg2jp25r_REjuJ_EWMOVVHmLQA53qHvMTlcHqdB.8xZwXcqbghsht8cGpOPky7c48XdLuWN
 qbVzgTtD7jyaJDaML_H4Ra7WBNYf60uxnZ5cEG7GrigLBwcyKc69welUL.8ANcOrDg518ECBa5yc
 ykdQ9hYCRLtYKT2K3nZ.uMeFAs5faK9BytF7dOlQSKmHsrQoJDx00mOVzs5qTL_2iaLC2HvbLfWK
 byCXaSrDVLm2q4mIEq3ElmEUTTd5rg1.NJ5Tv1aY_5jTPbjOatVjSmy4um94Be4hhUWgwPVHQ2Jq
 94UCG9bnAFjkgwIQ8a6bnE6VdBcMCamE5lB5QGghitFU4wkct9qm3Ds9TuVNDohCEQPXmUs3Qins
 naGUgbMwgrMceagQO_uiUmfwm5ZQDNwN5JhxX3kTog5.tD.NeD3A1TgIa_Z.ZU3xzEdH4pZDMj5d
 joZ5eHsKusHNj5LNNrS_AAMlR2uYt5vmcI.MgGmG1uLwKV3nm0qzF.H83DkguHhO5oKHy6VQOl1y
 g2R3B8wAoy.Ibhpy4tYlqOXP0xDvWqTfI91NBxw_8UdFzZgi_x6TMvD_qcPcqANIiiWQbMB1T8iO
 .BfM6uDOvVWTQvrQZ4QGNe7o3InViE6k8xCJEWLzTXGEU1aig6Hx.6JOPjmlIqgkzFFufi._zSat
 eWnicVZ4rA1WngBVRoah217UWSi_GiLdJM7CuP56v9M4iKrNbEsbqKJs9X02tMVp_r6_66L_VmEG
 .hHY2Y2OBLYuD6h8Osjrhg6x1utxsD6vvxk.nmQQASu4y44cwGdAVFoz5S9pqxHRwrtm2vt25zic
 uvPnm3soZvKhbXRvNRHXiEe7YjotRbLSwuV8SBl6DPXUZ36fcj9iH7HD6I4R7BojsGwCo6oab9GM
 poaS3xAK48tHB1ewu7PGP9gXx0HM99tEfZGdh0t17.vMc42ZKCR6v060-
X-Sonic-MF: <pjp@fedoraproject.org>
X-Sonic-ID: de48d154-cc05-4d84-9995-646901de3d4e
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic312.consmr.mail.sg3.yahoo.com with HTTP; Wed, 24 Apr 2024 10:41:30 +0000
Date: Wed, 24 Apr 2024 10:41:26 +0000 (UTC)
From: Prasad Pandit <pjp@fedoraproject.org>
To: Mauro Matteo Cascella <mcascell@redhat.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>, 
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Alexander Bulekov <alxndr@bu.edu>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Beniamino Galvani <b.galvani@gmail.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Alistair Francis <alistair@alistair23.me>, Stefan Weil <sw@weilnetz.de>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Helge Deller <deller@gmx.de>, 
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>, 
 Thomas Huth <huth@tuxfamily.org>, 
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, 
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, 
 Jan Kiszka <jan.kiszka@web.de>, Tyrone Ting <kfting@nuvoton.com>, 
 Hao Wu <wuhaotsh@google.com>, Max Filippov <jcmvbkbc@gmail.com>, 
 Jiri Pirko <jiri@resnulli.us>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Sven Schnelle <svens@stackframe.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Anthony Perard <anthony.perard@citrix.com>, 
 Paul Durrant <paul@xen.org>, Rob Herring <robh@kernel.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, 
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, 
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Message-ID: <1497808863.2030924.1713955286878@mail.yahoo.com>
In-Reply-To: <ac66952e-4281-4250-96f4-dc3d5b518d24@linaro.org>
References: <20230601031859.7115-1-akihiko.odaki@daynix.com>
 <20230601031859.7115-2-akihiko.odaki@daynix.com>
 <ac66952e-4281-4250-96f4-dc3d5b518d24@linaro.org>
Subject: Re: [PATCH v2 1/2] net: Provide MemReentrancyGuard * to qemu_new_nic()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: WebService/1.1.22256 YMailNorrin
Received-SPF: neutral client-ip=106.10.244.209;
 envelope-from=pjp@fedoraproject.org;
 helo=sonic312-19.consmr.mail.sg3.yahoo.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 FREEMAIL_FORGED_REPLYTO=2.095, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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
Reply-To: Prasad Pandit <pj.pandit@yahoo.in>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wednesday, 24 April, 2024 at 03:36:01 pm IST, Philippe Mathieu-Daud=C3=
=A9 wrote:
>On 1/6/23 05:18, Akihiko Odaki wrote:
>> Recently MemReentrancyGuard was added to DeviceState to record that the
>> device is engaging in I/O. The network device backend needs to update it
>> when delivering a packet to a device.
>>=C2=A0
>> In preparation for such a change, add MemReentrancyGuard * as a
>> parameter of qemu_new_nic().
>
>An user on IRC asked if this patch is related/fixing CVE-2021-20255,
>any clue?

* CVE-2021-20255 bug: infinite recursion is pointing at a different fix pat=
ch.
=C2=A0 ->=C2=A0https://bugzilla.redhat.com/show_bug.cgi?id=3DCVE-2021-20255

* And the this patch below has different issue tagged
=C2=A0 ->=C2=A0https://lists.nongnu.org/archive/html/qemu-devel/2023-05/msg=
08312.html
=C2=A0 Fixes: CVE-2023-3019


* They look different, former is an infinite recursion issue and the latter=
 is a use-after-free one.


Thank you.
---
=C2=A0 -Prasad

