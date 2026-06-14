Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47574CD98C5
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 23:09:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYtwP-0003MT-8g; Sun, 14 Jun 2026 19:08:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cminyard@mvista.com>)
 id 1wYtwN-0003MI-IJ
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 19:08:31 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cminyard@mvista.com>)
 id 1wYtwL-0007VI-4Y
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 19:08:31 -0400
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7e6e41cf7aeso1381184a34.0
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 16:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mvista.com; s=google; t=1781478507; x=1782083307; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p6pFjWWsIfqqCZ66avr+c90GYZE2XUW5V79QGwhi2X0=;
 b=kp69osKjDuT469Q0zEFIA34tEUZyfgl6nYCXJvf1Q0W9iB0GOiQJMpoBr6AZlwfR9i
 ASArJQOzMJYFd8jjyazsNN2QCgRn5mm8D3pHMBhe1k7Qx57SlYontCsOOfgihoaOqWGZ
 W1ptmWf6XLwYycJv+duSxTbop9RS3d2RiqMJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781478507; x=1782083307;
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=p6pFjWWsIfqqCZ66avr+c90GYZE2XUW5V79QGwhi2X0=;
 b=l9KI71hGfxtIjrLPtoyZz0GXK+oHEv5nfjQe2mieZbKoccrjVvY854yAhv92CJyWcY
 J5TzLLIkJpGdcMznJ2he6EihNZYFKw/XIPqN/eoTQtMvUpKDFy4nOWfDAacm+ZB7n8Ff
 rS/cgo8a/ha154hwexyYrJ4PXFn44Uf1buic8nc3NGYRbHpUbjhhHL934kRbGNFvLxJg
 fqrVEryT+WAV36QLepXKmWp8mtAuzLVguqaQPvle7cTb3EXi7Uz5rMYv2MITBQDVc1cI
 X+09a06mcDlqsajYZVb5bUARRgFlN8hJVAIxPWnFZIGJuDyrbmLpMxqLsbN69LUx6Hj0
 5wWg==
X-Gm-Message-State: AOJu0Yzh9WvMNb86Xu3URGFfppwgNEiAzQkksolq16vcM+0gLycTwTmb
 aXWogeY8CG/fCKRHom5UxHAGJ3DfwYz8LpuZau2HoCEuidK0RVINVGCiilWOE423KfE=
X-Gm-Gg: Acq92OHBi1M79jPO2Clf5JNpsMaQNAGshU4OhIaHXCziKhhl+45U0OPlBobxAMWZriT
 c3MRz2t3kx1K0xSK7t39buNok+mrPkxMQFQ4XvsvjXa10HvTPDxAh6IsDFpEc6oxjqnhFlgH+JC
 f1HD30yUf+TLsm7pbnLtQoW3bRs490y0mNlpDhuP00MXvXtqTuFyUtGzS2bbzDfAz6/2JSOuQZL
 SlPyEYjTQOYdxvICZEVztKCdFnfTfDH6disAnLktETns1kKuw20xkGRsRWG5lUiJEsbNqAhtRdy
 JyCYQp9E1tBzzN7b+Ywrll2PZkxVvgNX18JjDZjfqX8MEClV5YoeaN541rXr9NHrrYgtwikjMyc
 BGF2w78YbSF1J/l4Zj4Gzh+CQtLCp3V4qaWcVZylESD/txmSKTww50jNAa0qaX4/sJaWXmzhv98
 IeMuXhEeITBm8ScT8hcKVsipxArC5l/g==
X-Received: by 2002:a05:6830:924:b0:7dc:c4ae:a689 with SMTP id
 46e09a7af769-7e78466eb9emr8103552a34.2.1781478506754; 
 Sun, 14 Jun 2026 16:08:26 -0700 (PDT)
Received: from mail.minyard.net ([2001:470:b8f6:1b:d5ba:bfab:1f48:d9fa])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e7a3c2b08fsm1630239a34.8.2026.06.14.16.08.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 16:08:25 -0700 (PDT)
Date: Sun, 14 Jun 2026 18:08:19 -0500
From: Corey Minyard <cminyard@mvista.com>
To: Suresh Marisetty <smarisetty@yahoo.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 3/3] hw/ipmi: Accept any extern BMC msg_id to fix SMM
 firmware deadlock
Message-ID: <ai80Y2TVcU3tmoBj@mail.minyard.net>
References: <703047508.1680926.1781456306974.ref@mail.yahoo.com>
 <703047508.1680926.1781456306974@mail.yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
 micalg=sha-256; boundary="DVBeXuSZ/2D1DJnS"
Content-Disposition: inline
In-Reply-To: <703047508.1680926.1781456306974@mail.yahoo.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=cminyard@mvista.com; helo=mail-ot1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Reply-To: cminyard@mvista.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


--DVBeXuSZ/2D1DJnS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

A number of problems.

First, I'm having to top-post because you sent this as an HTML message,
which is not allowed on this mailing list.  There are a number of rules
and tools to validate patches, read the documentation on how to submit
patches.

Second, the coding style is bad.  It's just a hack.

Third, this whole fix is a hack.  The design of the BMCs here is to
allow only one outstanding message to an IPMI BMC.  The BT interface
capabilities response says this.  The entire design of this allows
only one outstanding message.  The changes you are making break
the checks around this, which is asking for trouble.  If you want
to fix this right, you will need to re-design this to handle
multiple outstanding messages.

Really, what's broken here is the firmware.  Having two separate pieces
of code talk to the same device without a shared device driver is just
broken.  Plus it's not querying the capabilities of the device.

It's strange that SMM holds the big QEMU lock.  I don't know much about
that, but it doesn't sound right to me.

Anyway, this certainly isn't the right fix.  I'm not sure what the
right fix is because I don't completely understand what's going on.

-corey

On Sun, Jun 14, 2026 at 04:58:26PM +0000, Suresh Marisetty wrote:
> From smarisetty@yahoo.com Fri Jun 13 2026From: Suresh Marisetty <smariset=
ty@yahoo.com>Date: Fri, 13 Jun 2026 18:00:03 -0700Subject: [PATCH 3/3] hw/i=
pmi: Accept any extern BMC msg_id to fix SMM firmware deadlockTo: qemu-deve=
l@nongnu.orgCc: Corey Minyard <cminyard@mvista.com>,=C2=A0 =C2=A0 Peter May=
dell <peter.maydell@linaro.org>,=C2=A0 =C2=A0 Philippe Mathieu-Daude <philm=
d@linaro.org>,=C2=A0 =C2=A0 Michael S. Tsirkin <mst@redhat.com>Message-Id: =
<20260613180000.1-3-smarisetty@yahoo.com>In-Reply-To: <20260613180000.1-0-s=
marisetty@yahoo.com>References: <20260613180000.1-0-smarisetty@yahoo.com>MI=
ME-Version: 1.0Content-Type: text/plain; charset=3DUTF-8=C2=A0ipmi_bt_handl=
e_rsp() accepts a response from the extern BMC only when:=C2=A0=C2=A0 =C2=
=A0 ib->waiting_rsp =3D=3D msg_id || msg_id =3D=3D 0xFF=C2=A0This strict ms=
g_id matching cannot be satisfied by firmware that sendsIPMI BT commands fr=
om System Management Mode (SMM).=C2=A0Root cause =E2=80=94 SMM and the QEMU=
 main loop are mutually exclusive:=C2=A0When a guest vCPU enters SMM, the v=
CPU thread holds the Big QEMU Lock(BQL) for the duration of the SMM handler=
=2E The ipmi-bmc-extern chardevreceive callback (ipmi_bmc_extern_receive) r=
uns in the QEMU main eventloop, which cannot execute while the BQL is held.=
 Consequently, any ACKsent by the extern BMC in response to an IPMI BT comm=
and issued fromSMM can only be received and processed by QEMU *after* the S=
MM handlerhas exited and released the BQL.=C2=A0This creates an unresolvabl=
e deadlock if SMM firmware polls for B_BUSYto clear after sending a BT fram=
e: the firmware waits inside SMM forB_BUSY to deassert, but QEMU cannot pro=
cess the extern BMC ACK (whichwould deassert B_BUSY) until SMM exits. SMM n=
ever exits because it iswaiting for B_BUSY.=C2=A0Secondary cause =E2=80=94 =
sequence counter divergence between DXE and SMM:=C2=A0UEFI platforms typica=
lly have multiple firmware modules sharing the sameIPMI BT interface: DXE-p=
hase drivers (e.g. TFLiteDxe) and SMM handlers(e.g. TrustForgeSmmDxe) each =
have independent instances of the BTlibrary with independent msg_id counter=
s starting from 0. DXE sendsframes with msg_id=3D0,1,... advancing QEMU's w=
aiting_rsp counter. WhenSMM subsequently sends frames starting from msg_id=
=3D0 or a differentbase, the msg_id values no longer match waiting_rsp, and=
 all SMM ACKsare silently dropped. B_BUSY remains set permanently.=C2=A0Cor=
rect design for SMM BT usage:=C2=A0Firmware that sends IPMI BT from SMM mus=
t use a "fire-and-forget"pattern: write the BT frame, assert H2B_ATN, and r=
eturn from SMMimmediately without polling for B_BUSY or B2H_ATN. QEMU then =
processesthe frame after SMM exits, the extern BMC sends an ACK, and QEMU c=
learsB_BUSY. The next SMI entry can drain the pending ACK from the BT FIFOb=
efore sending the next frame. This pattern requires QEMU to accept theexter=
n BMC ACK regardless of msg_id.=C2=A0Fix:=C2=A0Remove the waiting_rsp =3D=
=3D msg_id check. Accept any response from theextern BMC unconditionally. w=
aiting_rsp continues to increment so thatthe outgoing BT sequence presented=
 to the guest firmware (via theGET_BT_INTERFACE_CAPABILITIES "outstanding r=
equests" field) remainsconsistent.=C2=A0The existing msg_id =3D=3D 0xFF spe=
cial case for the extern init timeout issubsumed by this change.=C2=A0This =
bug affects any QEMU version where firmware sends IPMI BT commandsfrom SMM,=
 including all versions through 10.0.0.=C2=A0Reported-by: Suresh Marisetty =
<smarisetty@yahoo.com>Signed-off-by: Suresh Marisetty <smarisetty@yahoo.com=
>---=C2=A0hw/ipmi/ipmi_bt.c | 12 +++++++++---=C2=A01 file changed, 9 insert=
ions(+), 3 deletions(-)=C2=A0diff --git a/hw/ipmi/ipmi_bt.c b/hw/ipmi/ipmi_=
bt.cindex c3f7e25a91..8b4d2e7f03 100644--- a/hw/ipmi/ipmi_bt.c+++ b/hw/ipmi=
/ipmi_bt.c@@ -152,9 +152,15 @@ static void ipmi_bt_handle_rsp(IPMIInterface=
 *ii, uint8_t msg_id,=C2=A0 =C2=A0 =C2=A0IPMIInterfaceClass *iic =3D IPMI_I=
NTERFACE_GET_CLASS(ii);=C2=A0 =C2=A0 =C2=A0IPMIBT *ib =3D iic->get_backend_=
data(ii);=C2=A0-=C2=A0 =C2=A0 if (ib->waiting_rsp =3D=3D msg_id || msg_id =
=3D=3D 0xFF) {=C2=A0 /* 0xFF =3D extern init timeout */-=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ib->waiting_rsp++;-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rsp_len > (si=
zeof(ib->outmsg) - 2)) {+=C2=A0 =C2=A0 /*+=C2=A0 =C2=A0 =C2=A0* Accept any =
msg_id from the extern BMC unconditionally.+=C2=A0 =C2=A0 =C2=A0*+=C2=A0 =
=C2=A0 =C2=A0* SMM firmware cannot guarantee msg_id matches waiting_rsp: th=
e QEMU+=C2=A0 =C2=A0 =C2=A0* main loop is paused while the vCPU executes SM=
M (BQL held), so the+=C2=A0 =C2=A0 =C2=A0* extern chardev receive callback =
only runs after SMM exits. Firmware+=C2=A0 =C2=A0 =C2=A0* using fire-and-fo=
rget BT sends from SMM has independent msg_id+=C2=A0 =C2=A0 =C2=A0* counter=
s (per DXE/SMM module instance) that diverge from+=C2=A0 =C2=A0 =C2=A0* wai=
ting_rsp, causing all SMM responses to be silently dropped.+=C2=A0 =C2=A0 =
=C2=A0*+=C2=A0 =C2=A0 =C2=A0* waiting_rsp increments unconditionally to mai=
ntain BT sequencing.+=C2=A0 =C2=A0 =C2=A0*/+=C2=A0 =C2=A0 (void)msg_id;+=C2=
=A0 =C2=A0 {+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ib->waiting_rsp++;+=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 if (rsp_len > (sizeof(ib->outmsg) - 2)) {--2.39.0

--DVBeXuSZ/2D1DJnS
Content-Type: application/x-pkcs7-signature
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIINIQYJKoZIhvcNAQcCoIINEjCCDQ4CAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0B
BwGgggpVMIIFXzCCBEegAwIBAgIQD/rh8xorQzw9muFtZDtYizANBgkqhkiG9w0BAQsFADBl
MQswCQYDVQQGEwJVUzEVMBMGA1UEChMMRGlnaUNlcnQgSW5jMRkwFwYDVQQLExB3d3cuZGln
aWNlcnQuY29tMSQwIgYDVQQDExtEaWdpQ2VydCBBc3N1cmVkIElEIFJvb3QgRzIwHhcNMTkw
OTIzMTIyNTMyWhcNMzQwOTIzMTIyNTMyWjBqMQswCQYDVQQGEwJVUzEVMBMGA1UEChMMRGln
aUNlcnQgSW5jMRkwFwYDVQQLExB3d3cuZGlnaWNlcnQuY29tMSkwJwYDVQQDEyBEaWdpQ2Vy
dCBBc3N1cmVkIElEIENsaWVudCBDQSBHMjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoC
ggEBAOqxRa06rLwKBvrDb/qQ8RtXfeKA9o0A42oZbLF4GYr4Xdt9JE8r3PJRIOUZD1U3mEln
4S/aZoS54Q+5Ecs3q2GGT/Z82VeAPLeGvJoT0LS5t/zXeUcbMuDFWgyj33kiesnuusnOWvpI
SoxN+oBH4oo0+oUiHI65mMjMAlb93x6sabh9kKvHQvHC4x2u7wYv5+NXjnbOhJS/1NjGq+ug
LMXeldFMz0O5qFIDpn3aQGU0htyJQ2SZyxEqlUrgunsrYj9wgfW7XuhAi2j0y5d9oMT0SuVe
KFFnQhTEk5B3fq+OBOW0AU2JdW1r929UtRbAr8RpLt05WI2G2RNVVlHYaU0CAwEAAaOCAgQw
ggIAMB0GA1UdDgQWBBSlYiBQ3LtbV5etI4814lRsqX75TjAfBgNVHSMEGDAWgBTOw0q5mVXy
uNtgv6l+vVa1lzan1jAOBgNVHQ8BAf8EBAMCAYYwTAYDVR0lBEUwQwYIKwYBBQUHAwIGCCsG
AQUFBwMEBgorBgEEAYI3CgMEBgorBgEEAYI3FAICBgorBgEEAYI3CgMMBgkqhkiG9y8BAQUw
EgYDVR0TAQH/BAgwBgEB/wIBADA0BggrBgEFBQcBAQQoMCYwJAYIKwYBBQUHMAGGGGh0dHA6
Ly9vY3NwLmRpZ2ljZXJ0LmNvbTBFBgNVHR8EPjA8MDqgOKA2hjRodHRwOi8vY3JsMy5kaWdp
Y2VydC5jb20vRGlnaUNlcnRBc3N1cmVkSURSb290RzIuY3JsMIHOBgNVHSAEgcYwgcMwgcAG
BFUdIAAwgbcwKAYIKwYBBQUHAgEWHGh0dHBzOi8vd3d3LmRpZ2ljZXJ0LmNvbS9DUFMwgYoG
CCsGAQUFBwICMH4MfEFueSB1c2Ugb2YgdGhpcyBDZXJ0aWZpY2F0ZSBjb25zdGl0dXRlcyBh
Y2NlcHRhbmNlIG9mIHRoZSBSZWx5aW5nIFBhcnR5IEFncmVlbWVudCBsb2NhdGVkIGF0IGh0
dHBzOi8vd3d3LmRpZ2ljZXJ0LmNvbS9ycGEtdWEwDQYJKoZIhvcNAQELBQADggEBAHZrbCQC
o3MAIqR0kekGYrC70EAGRDRq11COufNEXhcpv3YH6BMhUoVinPPNgfo5HPrZAFrLK/KPXYdJ
dgkASGsINabAfY2ljUaJwKlpIewwjS6KuGEn59MgidaAUPh6lbetIoRsLhCqCzAnX1aL99fj
CMf4NMWLUC8TqotnnrKNuw4JSjx4fcQs+U5T1bbgnyDx+8ybONuIEDvinHdKDu2VjoECzez2
y/1IVTPlh57zBfjHJQFqLWzHdou8M+ucdJtr2swXII6s3nkq4pfEn7KnbzMS9quFSuyOGILc
g/3qVwaHNLM5R+8nB5gPI5+u5Uh56w1i+9Ds1pjYAiTHdeUwggTuMIID1qADAgECAhAImztE
U4o9odkEsuVgiJc8MA0GCSqGSIb3DQEBCwUAMGoxCzAJBgNVBAYTAlVTMRUwEwYDVQQKEwxE
aWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20xKTAnBgNVBAMTIERpZ2lD
ZXJ0IEFzc3VyZWQgSUQgQ2xpZW50IENBIEcyMB4XDTI0MDUwMzAwMDAwMFoXDTI2MDUwNjIz
NTk1OVowQjEcMBoGA1UEAwwTY21pbnlhcmRAbXZpc3RhLmNvbTEiMCAGCSqGSIb3DQEJARYT
Y21pbnlhcmRAbXZpc3RhLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAJm1
ZE9brEiQnF7EKiV+aYzHyqPFJ+z1wwdJ4wvNiwUCgXJejBxFj04Z7A62Yx6Sp59vfjbo05eA
IOyaLOFp3vbMBQAe8Qe4XrFv7wPcKZxwS+sgCuBvNs4NVGKYGjiKZW8WPq9ZcEl5BM8BLMrl
rchAUHJJcMdcEJUsed6rIB//EtnGOe74/vR1Tz3sN1WzC1Wa9COvcbLgVvWC/o4WysUfC9+f
9/5JzAiib7U7S/iRigkmEahibZgYKB7y6F1v9hxUwHxfa7GtJ8cv6LtRcPLhAO86GgXMfpgq
k3fxzQu8uwACpINbmQNLcRzg6mHFDYRK3mFp4puUnHO5EUJ8RgUCAwEAAaOCAbYwggGyMB8G
A1UdIwQYMBaAFKViIFDcu1tXl60jjzXiVGypfvlOMB0GA1UdDgQWBBQiHrUOKuj1vJe3OXAz
gOP5Qbl2FTAeBgNVHREEFzAVgRNjbWlueWFyZEBtdmlzdGEuY29tMBQGA1UdIAQNMAswCQYH
Z4EMAQUBATAOBgNVHQ8BAf8EBAMCBaAwHQYDVR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUFBwME
MIGLBgNVHR8EgYMwgYAwPqA8oDqGOGh0dHA6Ly9jcmwzLmRpZ2ljZXJ0LmNvbS9EaWdpQ2Vy
dEFzc3VyZWRJRENsaWVudENBRzIuY3JsMD6gPKA6hjhodHRwOi8vY3JsNC5kaWdpY2VydC5j
b20vRGlnaUNlcnRBc3N1cmVkSURDbGllbnRDQUcyLmNybDB9BggrBgEFBQcBAQRxMG8wJAYI
KwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmRpZ2ljZXJ0LmNvbTBHBggrBgEFBQcwAoY7aHR0cDov
L2NhY2VydHMuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0QXNzdXJlZElEQ2xpZW50Q0FHMi5jcnQw
DQYJKoZIhvcNAQELBQADggEBADkBdRyx41eUGmsYXBXt3WCsYeDr26rJL7lbx2PvqaZyRCJm
J9CN2TljF0YHsXSPU+un1RfUlYz+PtcNFIqNuSf3N5fGU0bEpSzXozd/nZ32yWFLkd5CzYyN
F1xrpbyP2a87jKM0uqEHXZFl7NPiAfEchjFCddciHTOXjN66L+kJ/ZsOoNJLG8yFN401EGew
Nk8z/hJjWqR7DG0/YWn9h7jQ5SmqkqyhLwTO9s6KoByacWuKpKWSc/DaOuWmROlROrOA1hD8
0sKqC6jGeLxNpiYzSwBy8qKF0weZdhcHUeO1HOm1csrvWl1UghnlR7SLir3bb5LiesTVvSuR
Q3aDywAxggKQMIICjAIBATB+MGoxCzAJBgNVBAYTAlVTMRUwEwYDVQQKEwxEaWdpQ2VydCBJ
bmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20xKTAnBgNVBAMTIERpZ2lDZXJ0IEFzc3Vy
ZWQgSUQgQ2xpZW50IENBIEcyAhAImztEU4o9odkEsuVgiJc8MA0GCWCGSAFlAwQCAQUAoIHk
MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDYxNDIzMDgx
OVowLwYJKoZIhvcNAQkEMSIEIO45rZ+Waj8BFcbAmNZn84UqKeudrF1okKjFaQ+Oa3nVMHkG
CSqGSIb3DQEJDzFsMGowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIw
CgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIHMA0G
CCqGSIb3DQMCAgEoMA0GCSqGSIb3DQEBAQUABIIBABRys0CJvQR66nnrYXoaPwd8beK5RCoT
iaLLEx0fHXMutK5CmpZB4r9KUnz+uGIdNMXFGkwbF/AlekO99IwwADMM/QMBRRbXLmh0TMGm
onleI6Po6ne3K3gAlC9VtcjPH0uYfeWsFGF0GmYBXlG3/pgsZlhMwpnChK1SALNuYClLwUN+
x/7apalO4zQ9hMTCc9Gw8UROruBifLRc/LNuhQSg9ykcf5f7fxY5bd5Czcco/KZkXKsdonl8
mdSGBtVMgJOEJxrwVuxsfcybEBhut0dUknGjqZXZ+FxzVaZtiW9g812IYLLI68QnjFoYcbHx
H6zBH6D4WVpOH8UpZeol5wY=

--DVBeXuSZ/2D1DJnS--

