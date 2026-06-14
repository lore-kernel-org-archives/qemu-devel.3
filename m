Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1BD1CD98C5
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 17:15:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYoPv-00073W-TP; Sun, 14 Jun 2026 13:14:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smarisetty@yahoo.com>)
 id 1wYoAQ-0004xF-AJ
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 12:58:38 -0400
Received: from sonic-uswe2-0020.asd.mail.yahoo.com ([34.2.78.19]
 helo=sonic.asd.mail.yahoo.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <smarisetty@yahoo.com>)
 id 1wYoAN-0003mR-D3
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 12:58:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1781456311; bh=eh0ti2lC3EIwDHe5bJF/QeUU4qDnyF9gvf6QgtQGtE4=;
 h=Date:From:To:Cc:References:Subject:From:Subject:Reply-To;
 b=I+2/rOJxiHbT1DhKL0nNW8Kij4TZG9Zk1osHaQN1NONE1a402Li1GIgK+NVW3vRLryOlopZN6X3DUbnB13vMUy1rGWwjKaWD+6wMueMwBhp+L9aS7/G4BbJ9K5fjliOMlKeqxgdBikMxXSXgu1jenltKwdV55+IbiC6w2OtkeOFtBtsVxPrWGgZYw9Wgqye+Eap+xmdC25HeK4/r66p7QpiKHSw8fYU3QWOLoCFBhktvXHQXL81gRgBl8KGHjJj/2zEELx06OlTKBpwKC+0/UEpCBOTMTP9j9ZKTDNh3vpNlGXHtSLWFBDvGY3/NO8S44I7Zzz1m31Q5zi7HCbp7Wg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1781456311; bh=Lu2MFarT4oLQCKYte2l0IRbLohjozouJTyCH03ib4I5=;
 h=X-Sonic-MF:Date:From:To:Subject:From:Subject;
 b=L6YE12EwgAIRccTlx6Twlu9wtAobXhmOeggh9wrW6QX9gm2bJWAAALEEVlwTcCxZYLQayvjCh//GmTUkP/8ppmiEV63uIiudtNdKdYSzjIqPuQlI68tnsEyKygEyJa897gxTTHm1hRapLuAjJxzeQHZ2l1zCsnXQiqjPBX/cL7WLpjIPewbabYPe02XLw43m3Qn3JXqjwI1qOUsfOviiI0kvOcUNEGKoUFKyVg/y+TncwjZ1BU7DAIF5hQtG6HcrcGozWKCguN6EtULmB3HsIjRfZp34vlMdfkgRnBOCAWmcXRFmiepAV0oQA66LUTWTD6/NmmgJkZRQSTdezh9bvw==
X-YMail-OSG: nYdtEI8VM1mtQek_I.Au848Mds3dYT1CpNpVWf9K1S.3oD_GRA2EVm9SEUzQAhZ
 MTY2ag_GdZndfpoSQ4.DtMnDX7GGxFpSI1TKu9m0V6jNcf6HhphdaurD5.IHhy3VTAYxxw01VCEv
 BVROtDoVhiMbUN6K8wl6bugYt_YgRy.7EXkNF.Ec9cbPdV6Hbt7E36jbcRmcrelbZpq_ZNiiB60g
 JS.wnWejUnxcZczDcOthZ3kLBVHYCOkTzjFmB9eBhJ0hMTVnZ4VX.if1haj2Aea7Mgfkcf6019nL
 piaTUQYv1ByP_a83cKiqUjuv5k0uNU_.m_7VtQzqjjAd.jt4ccxu_sWnibXvqjFVc_EKi4.j9KTo
 Mypz67zftTQ7FL4JcLNsCE3pmE5hNpFQQtO5cU5Jid1d_Yb.gM6aEpd0SpSH8_aMRYyyM5ZKa2PF
 67mmvWgWcsfsCGntonJ7ovW9z8b_5X9dLhY..E1B3npx_LoCrv5Pi55i_KtEHpFp4Md0nmnc.xZa
 GptqODQ0mqvcPoEOnSSS3cgapiqRyW7vwghVLvFIwLtdb6W2FUVRQRkFwBHsECVuhst3_wBYBcOy
 R4TFnfKOhx0X_WwmTPOLXToL_WpDb7MS7vWhx0.2KbAJPC54IwZ3AfH9tohsh.9X7LD.mOfWHvbG
 bXB7LpCAepTXr7eNmM1iUEPCmZWxCSCPLbrKtUQInKwZ.xpsUoHl_cLhdM2qffsCngHy4sPsYQG4
 DAvO5UkvD.MvbRJbhY1q_IacQeYBjnyDkNROXve4r2Ld4YEr7sfO2hSRokB2wr_EFzmqmEIJjys_
 ie5diT0Ba65tgW3pcI_95WompPCuIfNwB2q1EZl36Z4fu3L_vjNlv0d_0g3sc_VspzKP3fw2HKZ1
 XanVoCEqxs0gf3qtfWmHF.jGfpiQFHYue4qvFmZaZgDpBLr0QlATH0uRhMDdBc0DSD_HFq8062Co
 T5w6Q16Sd_rSPnW.Cv9R3QKw9_WC6gB8UBTgy__PXYGcWC4XYLfNG6haKQ7Ydqy6483ZXV0uFnZ4
 DmGO0wJTcx7OOE.lmKbj.S120E44xlGhXK3yl64goP5g0xAYyTACfwyBCg71e.ObCBf0siNZlada
 CDzMshq0t6C8ZWIiR6cFwhSrfi9zk1ED5VxyHbKzpB3zdtj5JeOITf6BcCwKXic4vRuUmGnOstFW
 SlXySiCaK6VRBgPJcXE7UWzF9Nm9ZlIszo0wk67mgfM5LhidTWMld7bPZrpGtG2lQRqYopfBG06i
 oFhAAzFRne3nYVTIYtDFm_s5uVODUuHVej0tr8u1ilQLMp0SsEGCnih.tluFG.zsY6ZS1IUjlH4F
 SUUDaYGOZZ6h6ShgTvUmReIArWOTzBmYWol5udUsLFuZOPj4LVV13TMhlzEXEijzWmTiZmJVCWIp
 pGQh_Q0I83mjgie5Jr0qf8D7hqEAxiE8zVyiCbrAcUfrTtmaz0aiFP89loJIYNztV1HkSd9q0fru
 baM8QIcxQo.LB3enUhKQ4g_QHZrx7fNgHikpfZvRXrS7KQJjrumKy9K6pVUCx6PQdDzVzXu5ZJyT
 DYWNnPaMU7vHjHKdc9nWwsg3nPqt5ACIiIrHYZcsPj7gqBdsAR0EmoyNlHl_oz..CLffxjDX3b17
 PmGvV5QiuGIdo0KTHEiMJoaPOshL6aS8um3COIQCse161fVlwE8yWtizX3dC2x.FpULeREVIzC0w
 gqTijqeKztNPKpB9m5mYE1kF09MDpSMZsksKC6JjPE_Zt7JryQxGWcTMN8T0IYTQ8f9MmPQklz_S
 4jdj.sUO4ptu2eMO_rXRu1WaKyXaykW2JyF7qYX14ZTEJK8UT0g07d3TIyM6uuxWo_1ZTe6zQINy
 LKk1_AHLZKjxaz9wfNedRTxHcJMpUVUGm54ZcyReQY9GbBB7KdZBkA4wqLnQAu_rzYSoeYNIh7Cc
 3EezHh0OVFiQL6.f2ads7qdh93OkNBHZXth1T0.7hgSBMAt3AztGBkHXCtPkwVgU_Dh1barTiVxm
 xaHMgRsKrBCwBczglELLp2wTUbPWg5l50FNMRQNp.4rcZjXT5Z5d4k1MKvujNZR.YbcKNCW1GXnX
 sw5A0Fd86QRwd2yvNiQ--
X-Sonic-MF: <smarisetty@yahoo.com>
X-Sonic-ID: 65a7f39f-19be-407f-a572-8d3f58177563
Received: from sonic.gate.mail.ne1.yahoo.com by
 mail-asdoutdeli-p-cin-uswe2-prod-sonicconsumer-svc-102 with HTTP;
 Sun, 14 Jun 2026 16:58:31 +0000
Date: Sun, 14 Jun 2026 16:58:26 +0000 (UTC)
From: Suresh Marisetty <smarisetty@yahoo.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Corey Minyard <cminyard@mvista.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Philippe Mathieu-Daude <philmd@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <703047508.1680926.1781456306974@mail.yahoo.com>
References: <703047508.1680926.1781456306974.ref@mail.yahoo.com>
Subject: [PATCH 3/3] hw/ipmi: Accept any extern BMC msg_id to fix SMM
 firmware deadlock
MIME-Version: 1.0
Content-Type: multipart/alternative; 
 boundary="----=_Part_1680925_1007325142.1781456306973"
X-Mailer: WebService/1.1.25918 YMailCLDNovation
Received-SPF: pass client-ip=34.2.78.19; envelope-from=smarisetty@yahoo.com;
 helo=sonic.asd.mail.yahoo.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_MIME_MALF=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 14 Jun 2026 13:14:38 -0400
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

------=_Part_1680925_1007325142.1781456306973
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From smarisetty@yahoo.com Fri Jun 13 2026From: Suresh Marisetty <smarisetty=
@yahoo.com>Date: Fri, 13 Jun 2026 18:00:03 -0700Subject: [PATCH 3/3] hw/ipm=
i: Accept any extern BMC msg_id to fix SMM firmware deadlockTo: qemu-devel@=
nongnu.orgCc: Corey Minyard <cminyard@mvista.com>,=C2=A0 =C2=A0 Peter Mayde=
ll <peter.maydell@linaro.org>,=C2=A0 =C2=A0 Philippe Mathieu-Daude <philmd@=
linaro.org>,=C2=A0 =C2=A0 Michael S. Tsirkin <mst@redhat.com>Message-Id: <2=
0260613180000.1-3-smarisetty@yahoo.com>In-Reply-To: <20260613180000.1-0-sma=
risetty@yahoo.com>References: <20260613180000.1-0-smarisetty@yahoo.com>MIME=
-Version: 1.0Content-Type: text/plain; charset=3DUTF-8=C2=A0ipmi_bt_handle_=
rsp() accepts a response from the extern BMC only when:=C2=A0=C2=A0 =C2=A0 =
ib->waiting_rsp =3D=3D msg_id || msg_id =3D=3D 0xFF=C2=A0This strict msg_id=
 matching cannot be satisfied by firmware that sendsIPMI BT commands from S=
ystem Management Mode (SMM).=C2=A0Root cause =E2=80=94 SMM and the QEMU mai=
n loop are mutually exclusive:=C2=A0When a guest vCPU enters SMM, the vCPU =
thread holds the Big QEMU Lock(BQL) for the duration of the SMM handler. Th=
e ipmi-bmc-extern chardevreceive callback (ipmi_bmc_extern_receive) runs in=
 the QEMU main eventloop, which cannot execute while the BQL is held. Conse=
quently, any ACKsent by the extern BMC in response to an IPMI BT command is=
sued fromSMM can only be received and processed by QEMU *after* the SMM han=
dlerhas exited and released the BQL.=C2=A0This creates an unresolvable dead=
lock if SMM firmware polls for B_BUSYto clear after sending a BT frame: the=
 firmware waits inside SMM forB_BUSY to deassert, but QEMU cannot process t=
he extern BMC ACK (whichwould deassert B_BUSY) until SMM exits. SMM never e=
xits because it iswaiting for B_BUSY.=C2=A0Secondary cause =E2=80=94 sequen=
ce counter divergence between DXE and SMM:=C2=A0UEFI platforms typically ha=
ve multiple firmware modules sharing the sameIPMI BT interface: DXE-phase d=
rivers (e.g. TFLiteDxe) and SMM handlers(e.g. TrustForgeSmmDxe) each have i=
ndependent instances of the BTlibrary with independent msg_id counters star=
ting from 0. DXE sendsframes with msg_id=3D0,1,... advancing QEMU's waiting=
_rsp counter. WhenSMM subsequently sends frames starting from msg_id=3D0 or=
 a differentbase, the msg_id values no longer match waiting_rsp, and all SM=
M ACKsare silently dropped. B_BUSY remains set permanently.=C2=A0Correct de=
sign for SMM BT usage:=C2=A0Firmware that sends IPMI BT from SMM must use a=
 "fire-and-forget"pattern: write the BT frame, assert H2B_ATN, and return f=
rom SMMimmediately without polling for B_BUSY or B2H_ATN. QEMU then process=
esthe frame after SMM exits, the extern BMC sends an ACK, and QEMU clearsB_=
BUSY. The next SMI entry can drain the pending ACK from the BT FIFObefore s=
ending the next frame. This pattern requires QEMU to accept theextern BMC A=
CK regardless of msg_id.=C2=A0Fix:=C2=A0Remove the waiting_rsp =3D=3D msg_i=
d check. Accept any response from theextern BMC unconditionally. waiting_rs=
p continues to increment so thatthe outgoing BT sequence presented to the g=
uest firmware (via theGET_BT_INTERFACE_CAPABILITIES "outstanding requests" =
field) remainsconsistent.=C2=A0The existing msg_id =3D=3D 0xFF special case=
 for the extern init timeout issubsumed by this change.=C2=A0This bug affec=
ts any QEMU version where firmware sends IPMI BT commandsfrom SMM, includin=
g all versions through 10.0.0.=C2=A0Reported-by: Suresh Marisetty <smariset=
ty@yahoo.com>Signed-off-by: Suresh Marisetty <smarisetty@yahoo.com>---=C2=
=A0hw/ipmi/ipmi_bt.c | 12 +++++++++---=C2=A01 file changed, 9 insertions(+)=
, 3 deletions(-)=C2=A0diff --git a/hw/ipmi/ipmi_bt.c b/hw/ipmi/ipmi_bt.cind=
ex c3f7e25a91..8b4d2e7f03 100644--- a/hw/ipmi/ipmi_bt.c+++ b/hw/ipmi/ipmi_b=
t.c@@ -152,9 +152,15 @@ static void ipmi_bt_handle_rsp(IPMIInterface *ii, u=
int8_t msg_id,=C2=A0 =C2=A0 =C2=A0IPMIInterfaceClass *iic =3D IPMI_INTERFAC=
E_GET_CLASS(ii);=C2=A0 =C2=A0 =C2=A0IPMIBT *ib =3D iic->get_backend_data(ii=
);=C2=A0-=C2=A0 =C2=A0 if (ib->waiting_rsp =3D=3D msg_id || msg_id =3D=3D 0=
xFF) {=C2=A0 /* 0xFF =3D extern init timeout */-=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 ib->waiting_rsp++;-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rsp_len > (sizeof(ib->o=
utmsg) - 2)) {+=C2=A0 =C2=A0 /*+=C2=A0 =C2=A0 =C2=A0* Accept any msg_id fro=
m the extern BMC unconditionally.+=C2=A0 =C2=A0 =C2=A0*+=C2=A0 =C2=A0 =C2=
=A0* SMM firmware cannot guarantee msg_id matches waiting_rsp: the QEMU+=C2=
=A0 =C2=A0 =C2=A0* main loop is paused while the vCPU executes SMM (BQL hel=
d), so the+=C2=A0 =C2=A0 =C2=A0* extern chardev receive callback only runs =
after SMM exits. Firmware+=C2=A0 =C2=A0 =C2=A0* using fire-and-forget BT se=
nds from SMM has independent msg_id+=C2=A0 =C2=A0 =C2=A0* counters (per DXE=
/SMM module instance) that diverge from+=C2=A0 =C2=A0 =C2=A0* waiting_rsp, =
causing all SMM responses to be silently dropped.+=C2=A0 =C2=A0 =C2=A0*+=C2=
=A0 =C2=A0 =C2=A0* waiting_rsp increments unconditionally to maintain BT se=
quencing.+=C2=A0 =C2=A0 =C2=A0*/+=C2=A0 =C2=A0 (void)msg_id;+=C2=A0 =C2=A0 =
{+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ib->waiting_rsp++;+=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 if (rsp_len > (sizeof(ib->outmsg) - 2)) {--2.39.0

------=_Part_1680925_1007325142.1781456306973
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html><head></head><body><div class=3D"yahoo-style-wrap" style=3D"font-fami=
ly:Helvetica Neue, Helvetica, Arial, sans-serif;font-size:16px;"><div dir=
=3D"ltr" data-setdir=3D"false"><div><div>From smarisetty@yahoo.com Fri Jun =
13 2026</div><div>From: Suresh Marisetty &lt;smarisetty@yahoo.com&gt;</div>=
<div>Date: Fri, 13 Jun 2026 18:00:03 -0700</div><div>Subject: [PATCH 3/3] h=
w/ipmi: Accept any extern BMC msg_id to fix SMM firmware deadlock</div><div=
>To: qemu-devel@nongnu.org</div><div>Cc: Corey Minyard &lt;cminyard@mvista.=
com&gt;,</div><div>&nbsp; &nbsp; Peter Maydell &lt;peter.maydell@linaro.org=
&gt;,</div><div>&nbsp; &nbsp; Philippe Mathieu-Daude &lt;philmd@linaro.org&=
gt;,</div><div>&nbsp; &nbsp; Michael S. Tsirkin &lt;mst@redhat.com&gt;</div=
><div>Message-Id: &lt;20260613180000.1-3-smarisetty@yahoo.com&gt;</div><div=
>In-Reply-To: &lt;20260613180000.1-0-smarisetty@yahoo.com&gt;</div><div>Ref=
erences: &lt;20260613180000.1-0-smarisetty@yahoo.com&gt;</div><div>MIME-Ver=
sion: 1.0</div><div>Content-Type: text/plain; charset=3DUTF-8</div><div>&nb=
sp;</div><div>ipmi_bt_handle_rsp() accepts a response from the extern BMC o=
nly when:</div><div>&nbsp;</div><div>&nbsp; &nbsp; ib-&gt;waiting_rsp =3D=
=3D msg_id || msg_id =3D=3D 0xFF</div><div>&nbsp;</div><div>This strict msg=
_id matching cannot be satisfied by firmware that sends</div><div>IPMI BT c=
ommands from System Management Mode (SMM).</div><div>&nbsp;</div><div>Root =
cause =E2=80=94 SMM and the QEMU main loop are mutually exclusive:</div><di=
v>&nbsp;</div><div>When a guest vCPU enters SMM, the vCPU thread holds the =
Big QEMU Lock</div><div>(BQL) for the duration of the SMM handler. The ipmi=
-bmc-extern chardev</div><div>receive callback (ipmi_bmc_extern_receive) ru=
ns in the QEMU main event</div><div>loop, which cannot execute while the BQ=
L is held. Consequently, any ACK</div><div>sent by the extern BMC in respon=
se to an IPMI BT command issued from</div><div>SMM can only be received and=
 processed by QEMU *after* the SMM handler</div><div>has exited and release=
d the BQL.</div><div>&nbsp;</div><div>This creates an unresolvable deadlock=
 if SMM firmware polls for B_BUSY</div><div>to clear after sending a BT fra=
me: the firmware waits inside SMM for</div><div>B_BUSY to deassert, but QEM=
U cannot process the extern BMC ACK (which</div><div>would deassert B_BUSY)=
 until SMM exits. SMM never exits because it is</div><div>waiting for B_BUS=
Y.</div><div>&nbsp;</div><div>Secondary cause =E2=80=94 sequence counter di=
vergence between DXE and SMM:</div><div>&nbsp;</div><div>UEFI platforms typ=
ically have multiple firmware modules sharing the same</div><div>IPMI BT in=
terface: DXE-phase drivers (e.g. TFLiteDxe) and SMM handlers</div><div>(e.g=
. TrustForgeSmmDxe) each have independent instances of the BT</div><div>lib=
rary with independent msg_id counters starting from 0. DXE sends</div><div>=
frames with msg_id=3D0,1,... advancing QEMU's waiting_rsp counter. When</di=
v><div>SMM subsequently sends frames starting from msg_id=3D0 or a differen=
t</div><div>base, the msg_id values no longer match waiting_rsp, and all SM=
M ACKs</div><div>are silently dropped. B_BUSY remains set permanently.</div=
><div>&nbsp;</div><div>Correct design for SMM BT usage:</div><div>&nbsp;</d=
iv><div>Firmware that sends IPMI BT from SMM must use a "fire-and-forget"</=
div><div>pattern: write the BT frame, assert H2B_ATN, and return from SMM</=
div><div>immediately without polling for B_BUSY or B2H_ATN. QEMU then proce=
sses</div><div>the frame after SMM exits, the extern BMC sends an ACK, and =
QEMU clears</div><div>B_BUSY. The next SMI entry can drain the pending ACK =
from the BT FIFO</div><div>before sending the next frame. This pattern requ=
ires QEMU to accept the</div><div>extern BMC ACK regardless of msg_id.</div=
><div>&nbsp;</div><div>Fix:</div><div>&nbsp;</div><div>Remove the waiting_r=
sp =3D=3D msg_id check. Accept any response from the</div><div>extern BMC u=
nconditionally. waiting_rsp continues to increment so that</div><div>the ou=
tgoing BT sequence presented to the guest firmware (via the</div><div>GET_B=
T_INTERFACE_CAPABILITIES "outstanding requests" field) remains</div><div>co=
nsistent.</div><div>&nbsp;</div><div>The existing msg_id =3D=3D 0xFF specia=
l case for the extern init timeout is</div><div>subsumed by this change.</d=
iv><div>&nbsp;</div><div>This bug affects any QEMU version where firmware s=
ends IPMI BT commands</div><div>from SMM, including all versions through 10=
.0.0.</div><div>&nbsp;</div><div>Reported-by: Suresh Marisetty &lt;smariset=
ty@yahoo.com&gt;</div><div>Signed-off-by: Suresh Marisetty &lt;smarisetty@y=
ahoo.com&gt;</div><div>---</div><div>&nbsp;hw/ipmi/ipmi_bt.c | 12 +++++++++=
---</div><div>&nbsp;1 file changed, 9 insertions(+), 3 deletions(-)</div><d=
iv>&nbsp;</div><div>diff --git a/hw/ipmi/ipmi_bt.c b/hw/ipmi/ipmi_bt.c</div=
><div>index c3f7e25a91..8b4d2e7f03 100644</div><div>--- a/hw/ipmi/ipmi_bt.c=
</div><div>+++ b/hw/ipmi/ipmi_bt.c</div><div>@@ -152,9 +152,15 @@ static vo=
id ipmi_bt_handle_rsp(IPMIInterface *ii, uint8_t msg_id,</div><div>&nbsp; &=
nbsp; &nbsp;IPMIInterfaceClass *iic =3D IPMI_INTERFACE_GET_CLASS(ii);</div>=
<div>&nbsp; &nbsp; &nbsp;IPMIBT *ib =3D iic-&gt;get_backend_data(ii);</div>=
<div>&nbsp;</div><div>-&nbsp; &nbsp; if (ib-&gt;waiting_rsp =3D=3D msg_id |=
| msg_id =3D=3D 0xFF) {&nbsp; /* 0xFF =3D extern init timeout */</div><div>=
-&nbsp; &nbsp; &nbsp; &nbsp; ib-&gt;waiting_rsp++;</div><div>-&nbsp; &nbsp;=
 &nbsp; &nbsp; if (rsp_len &gt; (sizeof(ib-&gt;outmsg) - 2)) {</div><div>+&=
nbsp; &nbsp; /*</div><div>+&nbsp; &nbsp; &nbsp;* Accept any msg_id from the=
 extern BMC unconditionally.</div><div>+&nbsp; &nbsp; &nbsp;*</div><div>+&n=
bsp; &nbsp; &nbsp;* SMM firmware cannot guarantee msg_id matches waiting_rs=
p: the QEMU</div><div>+&nbsp; &nbsp; &nbsp;* main loop is paused while the =
vCPU executes SMM (BQL held), so the</div><div>+&nbsp; &nbsp; &nbsp;* exter=
n chardev receive callback only runs after SMM exits. Firmware</div><div>+&=
nbsp; &nbsp; &nbsp;* using fire-and-forget BT sends from SMM has independen=
t msg_id</div><div>+&nbsp; &nbsp; &nbsp;* counters (per DXE/SMM module inst=
ance) that diverge from</div><div>+&nbsp; &nbsp; &nbsp;* waiting_rsp, causi=
ng all SMM responses to be silently dropped.</div><div>+&nbsp; &nbsp; &nbsp=
;*</div><div>+&nbsp; &nbsp; &nbsp;* waiting_rsp increments unconditionally =
to maintain BT sequencing.</div><div>+&nbsp; &nbsp; &nbsp;*/</div><div>+&nb=
sp; &nbsp; (void)msg_id;</div><div>+&nbsp; &nbsp; {</div><div>+&nbsp; &nbsp=
; &nbsp; &nbsp; ib-&gt;waiting_rsp++;</div><div>+&nbsp; &nbsp; &nbsp; &nbsp=
; if (rsp_len &gt; (sizeof(ib-&gt;outmsg) - 2)) {</div><div>--</div><div>2.=
39.0</div></div><br></div></div></body></html>
------=_Part_1680925_1007325142.1781456306973--

