Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A0ADEE0AEC
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Feb 2026 22:05:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voqPz-0000p0-TS; Sat, 07 Feb 2026 17:04:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1voqPx-0000oZ-En
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 17:04:41 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1voqPv-0006GV-23
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 17:04:40 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 617D7Z042385879
 for <qemu-devel@nongnu.org>; Sat, 7 Feb 2026 22:04:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 D/s0R+Hm/aqoAwRRRlWFMr+jK7Tp6UFjPj79klZuRNA=; b=Jx85iYuapFBZ8XwL
 R5262t/GvOpnf56h/M1/VsLy/V6PQgYUEUYxA3avAKoVL7neLd3VKF2HYK8TxlaC
 g0CbRU8xFjFKpDIHHL1MguI3hYOcselQhTkJouec/uoAI6QNSR9dXzLwuuPMbrdd
 WcYOOtwyXCI0+vkgswSf5+YSP4syCTuN8JmcHrsEcQqzQ6xJjM2mbL1vB9XNNJDj
 0MKWRJcAd1imqxNvTdpD1kao2ljIQPcJuZ0fJ5gm8oh6mf9pQuKun2I6+Qws2UUP
 PeaoYrEskRj0P6c8hHWdsIlr5M4T2F/tcOT8aXXcJvHV/nQOHWZoabyM802ArFZS
 xNYZUA==
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c5xdescdd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 07 Feb 2026 22:04:36 +0000 (GMT)
Received: by mail-yx1-f71.google.com with SMTP id
 956f58d0204a3-64956cfd789so2402395d50.1
 for <qemu-devel@nongnu.org>; Sat, 07 Feb 2026 14:04:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770501875; cv=none;
 d=google.com; s=arc-20240605;
 b=d6lOS1Nv4Nzi2BdyQp7uiPg/M+L8ABDu82w/M4Ep6ZhQ/2M0YA+4WosAo+SObctJQt
 2Vep6b3qF1O+EuHLgnOsbSvlU6RQfbeHKbgXKldJyF0Izj5JHeNwfK0XENf8WHJxja1v
 Qkz03+auqU3gDAJ207CIDgVLcvY7GSpuPC+fVYtdTYmHUKfz0J/j22xjJ+HgzCPztUNy
 ZrjP7Mz0fOrKh2eqhMQwFVF5xqK2mj2XK+/64Pbj/WKMbE4b/OSRPcijzjwZwwTHxENc
 p6p/L5nWsEy/U8XsN8apkJXZUyskZpX69xEKG5Bnia2IjGFtD6vE2Vg51ZkR3JS2rQsP
 2MHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=D/s0R+Hm/aqoAwRRRlWFMr+jK7Tp6UFjPj79klZuRNA=;
 fh=jp7UtZyNKU5BLub/l/lrQwwunp/RKLB3JAM18k7wLps=;
 b=Q9PXBOR0JmJKF1wWznx/+P43PqdlfcEMqc5l045vicyuWMc3E0QNbrudavbvKsNNOe
 WN4QOgUBpzm7i8lsR7gC7GD5sgDi7cY9F/ZBPOo+M7f2M4sETuCA1XPNekwE0gHCiY2L
 cvyA9X5dVYh9kV51hN0C4mqvyU1CMYUJpt3Eqh267Vp/U7As4D99u+MfFfbNkNEYOlqT
 86kP+OOXxiVfw81feg6/p6/rwW1xGKxb5bQg5SUHq+H2LqRVfXMBA6LKqq2kiQReWW5n
 ETPv/6kxDb7wFxA9yvVMrIA0653lI4/wh7ppYrwaNH+rvdoLgphJs/U1RlC7xpcIIBFH
 s/FA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1770501875; x=1771106675; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D/s0R+Hm/aqoAwRRRlWFMr+jK7Tp6UFjPj79klZuRNA=;
 b=kNWJE3IRdA/Mu9TsyrIW0lPSTJH/uuBGMdkyIZtKy9l4F18n35ekcwdv11/ED/XdbG
 qa5cVrd6norv9aKGNsMUj6eHRwA6x57MHWnaYOHfQvdL01rihwSUy6m0GHvyKQGNof/f
 8d1XbIeyoXI1cjlIuYS0ptrLEbJm/k8af1mFMuaB6rZzcWXkoex2OBnPecpJ24/NeZ73
 51hgKT2FpAJd6O1+KcG0qlZ3dm49eFqNPrEYGJatRidD0IvwGWNHbdf/GZ2/rDH4VpDH
 SlMFVxu+OpTh5oXY9sQNcuyXsKqFoOlAEtR7t3pfreBP4rC+bBreUCXNVfS/3HZNIT5j
 Wc9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770501875; x=1771106675;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=D/s0R+Hm/aqoAwRRRlWFMr+jK7Tp6UFjPj79klZuRNA=;
 b=T0BR8YFot6ns5uARrg9p1V2uea/Hzm4bXwdUNVFDOC8Ky/X5chDIHoA3mkeBjz28Is
 ui4s1VEi5PL1lYIrlpC7JxgDjzjIfdWQ+v7TVbSOqbs5DTHAOtsuNcnj+tyiw+0T4mkt
 DCm+JctrdxoKqw/UzT5CNExgVPZfWmVcvFtI5d7suRCl2S6aVOJLoF9NUbuXRJn7hux2
 odvMKIbrRaH5xpFtDDa2f6E40gPynJHF7ItaBh1ocbEHQJI3LgTTYF8ArbAwgm/SUlVT
 Z/P+X4OvMV37ohEHUPyp8xAT8+bWzzuqJyhr+QZJU47N000PSrU8rO+q/LXGa3xcHEJb
 cWMQ==
X-Gm-Message-State: AOJu0YzS/54D47eH9c04J3EhD58KxTYEhvo5StCcb6caVZTiRUXZcSYX
 qBp+4dYzq8A2vtUov0Cbqw2NmC/CHc02oVLxMoAvKtFFiPu46xECOiZtW96RFiHG3wmK9+4CWh3
 ZQaP/kQYGzZYlmojTVBbLyIrR3dC5C44yvHaLlMMyiGYeGH1gbWS/joqwWGfniwnUreeHp9D8Ds
 pek0I1Y6OuX0IhPZfmTun1F3mwBn24Oi43
X-Gm-Gg: AZuq6aJVRE4bMsVxk0lwg1qIwmq5gTlpZXtayjCsNBkSzcNvkt9UJTh0x8uXdUEZU/B
 I6TOxhiGpYksyNCkUFuzE3DHozr41Pknv7Dfz2PU3jBZZJBBqs8PO/RxYHYEEbg+AMaajOsTf4T
 TLBt5YcPwesN0rVwhqHydM326jfx8n+s7bAkDUSaSfCrxynooEWCcXaSmqyn1NJDPgAlI2
X-Received: by 2002:a53:cb0e:0:b0:649:ed1f:6ca4 with SMTP id
 956f58d0204a3-649f1e57c21mr5244923d50.19.1770501875258; 
 Sat, 07 Feb 2026 14:04:35 -0800 (PST)
X-Received: by 2002:a53:cb0e:0:b0:649:ed1f:6ca4 with SMTP id
 956f58d0204a3-649f1e57c21mr5244907d50.19.1770501874879; Sat, 07 Feb 2026
 14:04:34 -0800 (PST)
MIME-Version: 1.0
References: <20260207180632.1042754-1-brian.cain@oss.qualcomm.com>
 <20260207180632.1042754-3-brian.cain@oss.qualcomm.com>
 <CAATN3Noay=pVLA5-d8MMYMLq=QDSwX2zQZwdt1mzA-cjdCV0Eg@mail.gmail.com>
In-Reply-To: <CAATN3Noay=pVLA5-d8MMYMLq=QDSwX2zQZwdt1mzA-cjdCV0Eg@mail.gmail.com>
From: Brian Cain <brian.cain@oss.qualcomm.com>
Date: Sat, 7 Feb 2026 16:04:18 -0600
X-Gm-Features: AZwV_QjZFv6W0G5D99ENNzvuQzckomdtATFwFy-SUWoEVLC-rvCMZ5cELSVuVhw
Message-ID: <CAEqNhNZDSCdVKOTJVWBv7=z3O0a4p-hy1z+GJQn9GJ4hZ8BJkg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] target/hexagon: Reject duplex encodings with
 duplicate dest registers
To: Taylor Simpson <ltaylorsimpson@gmail.com>
Cc: qemu-devel@nongnu.org, alex@alexrp.com,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=Ddcaa/tW c=1 sm=1 tr=0 ts=6987b6f4 cx=c_pps
 a=ngMg22mHWrP7m7pwYf9JkA==:117 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=p0WdMEafAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=KKAkSRfTAAAA:8 a=vuVzPxxrbvWU29kM2iIA:9 a=QEXdDO2ut3YA:10
 a=yHXA93iunegOHmWoMUFd:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: HgXi2Dn6g-DBm_IQ1S2lK24qzIMbiwWZ
X-Proofpoint-GUID: HgXi2Dn6g-DBm_IQ1S2lK24qzIMbiwWZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA3MDE4MCBTYWx0ZWRfX132F5UBY/QyZ
 +J2YAYb476rxmueCRsQwUIHaR7JediSahT01PTBKUiLdlbxz5r/ijc+i+7fKJcmPFFRGO4wH/DE
 TUGVTQ8vLs0No5boizU6ao06OQ2x9X9DTL8/iST8qok0Z0Ydtj7tJPxPgJn2bOs3HITc4E2Gv5V
 UPiBkkhlEJz8hy1M+I3FSz/ZBYdW5hjYxo+7/xO3Wj7tqmepYyL/cVoGQNKu3cpMeg2lw8Pm05J
 oMq3lBcKiuc/uC6DnZrzyTp6NnmlIS/ze1q/7SsbLJEa3ILIwJ7S/BDlb4ilvnubVHYpj8MxLfH
 o8Ijtx/VqJfut/28F11/FuzFNwKvGJ10nDyPzs/2z8TdQuLyu3hJGMinvXfDS3e0FXeNXlXuZRZ
 4poi9cJMufhgWgT1J/JJoeaVa+D26wpXJP+2dumV1eLR+1o8hBLzWd8M50Mc+d1V0Iy/z3igMdA
 BbBtCUXHrvesfjRaC5A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-07_02,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1015 suspectscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602070180
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Sat, Feb 7, 2026 at 3:58=E2=80=AFPM Taylor Simpson <ltaylorsimpson@gmail=
.com> wrote:
>
>
>
> On Sat, Feb 7, 2026 at 11:06=E2=80=AFAM Brian Cain <brian.cain@oss.qualco=
mm.com> wrote:
>>
>> A duplex encoding like 0x00000000 decodes as two loads that both write r=
0.
>>
>> Add a check in decode_insns() after both sub-instructions decode
>> successfully to verify they don't write the same destination register.
>>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2696
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>  target/hexagon/decode.c              | 12 ++++++++++++
>>  tests/tcg/hexagon/invalid-encoding.c | 29 ++++++++++++++++++++++++++++
>>  2 files changed, 41 insertions(+)
>>
>> diff --git a/target/hexagon/decode.c b/target/hexagon/decode.c
>> index 69ba1ec96c..90499fc320 100644
>> --- a/target/hexagon/decode.c
>> +++ b/target/hexagon/decode.c
>> @@ -501,12 +501,24 @@ decode_insns(DisasContext *ctx, Insn *insn, uint32=
_t encoding)
>>
>>          /* The slot1 subinsn needs to be in the packet first */
>>          if (decode_slot1_subinsn(ctx, slot1_subinsn)) {
>> +            Insn *slot1_insn =3D insn;
>>              insn->generate =3D opcode_genptr[insn->opcode];
>>              insn->iclass =3D iclass_bits(encoding);
>>              ctx->insn =3D ++insn;
>>              if (decode_slot0_subinsn(ctx, slot0_subinsn)) {
>>                  insn->generate =3D opcode_genptr[insn->opcode];
>>                  insn->iclass =3D iclass_bits(encoding);
>> +                /*
>> +                 * Check that the two sub-instructions don't write the =
same
>> +                 * destination register (e.g., encoding 0x0 decodes as =
two
>> +                 * loads both writing R0, which is an invalid packet).
>> +                 */
>> +                if (insn->dest_idx >=3D 0 && slot1_insn->dest_idx >=3D =
0 &&
>> +                    insn->regno[insn->dest_idx] =3D=3D
>> +                        slot1_insn->regno[slot1_insn->dest_idx]) {
>> +                    ctx->insn =3D --insn;
>> +                    return 0;
>> +                }
>>
> Isn't this a more general problem than what is checked here?  What if two=
 non-duplex instructions write the same register?  What if an instruction w=
rites more than one register (e.g., post-increment load)?

It is, yeah.  I mentioned in the cover letter that I planned to land that l=
ater.

But ok -- I can move it here into this series.

> Let the decoding go ahead and finish, then add a check for duplicate writ=
es for the whole packet.  Look at ctx_log_reg_write - called during analyze=
_packet.
>
> Thanks,
> Taylor
>

