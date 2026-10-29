Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B685606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 23:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CAtci3p0;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ac47LshT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMZ9X-00022t-Io; Thu, 29 Oct 2026 19:03:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMZ9W-00022R-3s
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 19:03:22 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMZ9U-0004Ct-8l
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 19:03:21 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TLZbHC289285
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 23:03:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 o25Scd3tPhSIaFblyzPcWYZ1yMS3HSeirki1qHRGF90=; b=CAtci3p0FuQVJvI8
 pOqtScHeSRqM/zst2mXjUH+a8TCuEDF1Nt3aGu226hCbmFr/XKIVVdjtj8KR84lL
 N3vx+wfMhMn5zYlY8DB9EC+MHXL8oZfu3SblyscG7p5cvvivL/GurWFpybp1P8eW
 NzpyHxOdmP+IEdcwTo5/lqZ7u24NFPgmJNtLyjYhDhPKnJGgn2JIPdzlYtpXlX47
 UEvNeL7j3t+ELvDsXxjJ7JfvdE1aoHlKKdScAwLToa22DQuiHKa82m3P3FvP19kX
 pg9ThWpWCwVOoNgneoB9/jCFOczmGuqWFXVyTwpySBaREU7QtgFLkuSnQqxNmFfw
 fdBPUA==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6p09cq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 23:03:19 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-1383723dfddso182545c88.0
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 16:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793314998; x=1793919798; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=o25Scd3tPhSIaFblyzPcWYZ1yMS3HSeirki1qHRGF90=;
 b=ac47LshTj/pa50W3YarN95CmCkJX/BP7r6P9gmNHv0kUDLLcqg0kOZqVH2FO1MmAdl
 9si2sbv5BzJ9GzWnqRVSn/Qb4qHc3P1l0bmLsdFGo3nfEj+ktBFVZYxyeguElbYOf0d/
 Fy/+VV5u8nLJ7SOcl0yLokFhS64CjbgUDEg41Isush7WykUXWBnvx0QB2SqLaPEr5lUC
 i6AmbOYNtQDcwEMOfepcTLcdESHqq2h20ezdF35fXuL/O4fd/+coy3HFbH4YlsiQrp0y
 h90MZh0dU5exdtelB0WRfewZsOfWC1RE9F/17ioKCuUT2X3aYzEIBUeT5PC1rjq9zM6D
 fu7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793314998; x=1793919798;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=o25Scd3tPhSIaFblyzPcWYZ1yMS3HSeirki1qHRGF90=;
 b=G0pvMfHk1V/bROo7VenCe/b8uy+kq7lJjrauChUYwJks7ubNiTr7vTxUcuY1SkpGb7
 U6ZsTl+w/oz8XplDybyEaXzSUj7DNgiBJ+zQgaZvYsLTNRQFXTK0pnBD58VRVZj+uSid
 Cc+jnR2DcpW7DZn8v5M3v1TytOOSzYNVpq+mxw63BFJCv0jr88XfEjAT6Z4Ahd16LPPa
 a/R207vZA/VGVDwqEUKI9N2XUp8hLx7/SjuydyyEX5iH8yoU7SF7ZDFCAGWMOWHglEYK
 iyBX+1Hb9svLSRcfnTAFFJrNQg3lUYGisq9FrTLeuwhZJn/Iq9MWPIsQNP7Ipt7lqFAW
 FhiA==
X-Gm-Message-State: AFq9FYIqrlpb64Fph5rmsyI90z2VpVAu6aq7AquABhDfYOjPMDuH4FEO
 hCgYpzs/J8u3XqbIUboJ7nygfnFuC77zqR9SUbNz7FcVRBs/sqeLnsA2WxJMRt161INWE/JCyeD
 y3aarwEFuVI5rPa+DKX0iCoGVfLsnF+B+Q4l8Q1M8Wor7eA/mdMt+VUEmW2P1PJYyWg==
X-Gm-Gg: AYBFou0dhWCcywFv5icFqkuEGBZEWYUeZZFEuzZ9aEGG4XmnHu2foR1Uvq/6gHKp1i5
 tBihmHe2e1TU/LkGV1TVE5QsfrIobmJxTVh4fqkoisicprQMR6BUa9zQyaHtm0z34aaShB31vE/
 02wRKVrcV/IT5qLD7tEz44p6bowT34hX8FP1Lz10Y1ZJF1HLaQ2OfWnNlWasq4pwYfe8qspSmkT
 S9tjPVBdv59nCDQqy+6YfhAgXBb2bMh1L3RIHG7Jx90mdtw4Z1torHcpAUIpS7gprOLLQf6o7W7
 /Iw4rk8rYAt2lqDFpOhweH5RXhjlEjE69aASsfHdE37rOZTuWXABCJfSuK85+/Sr5UoXxRB2ep3
 Wx/QzMpDTMa7ioNiLrkB0gfh1wJSspNvNs9N9JJ8LEBK636QpcTajJxNr8xJrIs6PD/q3xaclh5
 uZqUhNCn/1hUziJdakb3o9
X-Received: by 2002:a05:701b:4211:10b0:1a7:99b9:2eb9 with SMTP id
 a92af1059eb24-1ac5de4e8a1mr651599c88.27.1793314998042; 
 Thu, 29 Oct 2026 16:03:18 -0700 (PDT)
X-Received: by 2002:a05:701b:4211:10b0:1a7:99b9:2eb9 with SMTP id
 a92af1059eb24-1ac5de4e8a1mr651553c88.27.1793314997240; 
 Thu, 29 Oct 2026 16:03:17 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1ac193b8179sm2034887c88.11.2026.10.29.16.03.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 16:03:15 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>
Subject: [PATCH 2/8] hw/hexagon: add the HMX context device
Date: Thu, 29 Oct 2026 16:03:04 -0700
Message-Id: <20261029230310.1632334-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261029230310.1632334-1-brian.cain@oss.qualcomm.com>
References: <20261029230310.1632334-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA5MCBTYWx0ZWRfX56WP9QwrzDap
 H3WUylDlri3/Q5Tiz2bFK0LHWFwj8fLzRzBF/7E2NFVjCR9ew8ldvvtd74mMdzTdDO3Ka3QGc6E
 Q7ewtaZbBKyu8K20e/b4vNejb9sbM1bLkpxO2ai+kS68Dq78fHn/DsHyt6ONEmXnq4I5ls4FAjs
 yMN3ZcepA7EfDP6r27UwXBHgHSqdB43x2C6EQFrvhfYtXg+HwgcCv/MI4Rk/wx/xwcLEi+6GtxY
 NYXKxZmOE9IASyor0f4lgFdPos03A3xvGYn4MPd3utrIVHAkRvVSRtUWxef+9OF7suzjWEqaVsz
 IeoR11vIHPenxpizKs6DjS4uPXd8R1PcO4k8wR1oHiDp2ZIIqmuN0odhngO62AMTa6brDa3kQ/3
 Zt73rlW3LwjS7bqiPBWmPngjYzP9PhHpvYQdEvOlGukqzyWCbjPXdKtwhtbmJ8XxOkojguIuNWW
 siKUMLWa/UPozoUn/FQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA5MCBTYWx0ZWRfXyNa331FIfBTx
 v4iWAkK5uTfZsAvspMAKYnPdxoOubPW7XbL6A3QAelugNKUG9XQ6ZCX0QCoNfsd9r/8nk/U9jyU
 LCVbmrAxe0wmMYo4EQmyzxWMGrFlH6c=
X-Proofpoint-ORIG-GUID: XrlYS5yzs0NDxyDGkkeAnDwrIMNVhwlK
X-Proofpoint-GUID: XrlYS5yzs0NDxyDGkkeAnDwrIMNVhwlK
X-Authority-Analysis: v=2.4 cv=TL3Q2Fla c=1 sm=1 tr=0 ts=6ae3d0b7 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=GkCZVEeUe3Q-cCnmmhAA:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290090
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

QWRkIGEgc3lzYnVzIGRldmljZSB0aGF0IG93bnMgdGhlIEhNWCBzdGF0ZS4gIEEgY29yZSBoYXMg
b25lIEhNWCB1bml0CnNoYXJlZCBieSBhbGwgaXRzIHRocmVhZHMuCgpTaWduZWQtb2ZmLWJ5OiBC
cmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogaW5jbHVkZS9ody9o
ZXhhZ29uL2hleGFnb24uaCAgICAgICAgICAgICB8ICA1ICsrKwogaW5jbHVkZS9ody9oZXhhZ29u
L2hleGFnb25faG14X2NvbnRleHQuaCB8IDI0ICsrKysrKysrKysrKysrCiBody9oZXhhZ29uL2hl
eC1zdWJzeXMuYyAgICAgICAgICAgICAgICAgIHwgMTYgKysrKysrKysrKwogaHcvaGV4YWdvbi9o
ZXhhZ29uX2hteF9jb250ZXh0LmMgICAgICAgICB8IDQwICsrKysrKysrKysrKysrKysrKysrKysr
KwogaHcvaGV4YWdvbi9tZXNvbi5idWlsZCAgICAgICAgICAgICAgICAgICB8ICAxICsKIDUgZmls
ZXMgY2hhbmdlZCwgODYgaW5zZXJ0aW9ucygrKQogY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUv
aHcvaGV4YWdvbi9oZXhhZ29uX2hteF9jb250ZXh0LmgKIGNyZWF0ZSBtb2RlIDEwMDY0NCBody9o
ZXhhZ29uL2hleGFnb25faG14X2NvbnRleHQuYwoKZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvaGV4
YWdvbi9oZXhhZ29uLmggYi9pbmNsdWRlL2h3L2hleGFnb24vaGV4YWdvbi5oCmluZGV4IDY3OGU2
NThhNmQzLi5jNDVjMmJlZmE1MCAxMDA2NDQKLS0tIGEvaW5jbHVkZS9ody9oZXhhZ29uL2hleGFn
b24uaAorKysgYi9pbmNsdWRlL2h3L2hleGFnb24vaGV4YWdvbi5oCkBAIC00MCw2ICs0MCwxMSBA
QCB0eXBlZGVmIGVudW0gewogI2RlZmluZSBIRVhBR09OX0xBVEVTVF9SRVYgdjg1CiAjZGVmaW5l
IEhFWEFHT05fTEFURVNUX1JFVl9VUFBFUiBWODUKIAorI2RlZmluZSBIRVhBR09OX0NPUFJPQ19I
TVggKDFVIDw8IDIpCisKKyNkZWZpbmUgSEVYQUdPTl9DRkdUQUJMRV9IQVNfSE1YKHQpIFwKKyAg
ICAoKHQpLT5jb3Byb2MyX3JlZzAgIT0gMCB8fCAoKHQpLT5jb3Byb2NfcHJlc2VudCAmIEhFWEFH
T05fQ09QUk9DX0hNWCkpCisKIC8qCiAgKiBDb25maWcgdGFibGUgYWRkcmVzcyBiYXNlcyByZXBy
ZXNlbnQgYml0cyBbMzU6MTZdLgogICovCmRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L2hleGFnb24v
aGV4YWdvbl9obXhfY29udGV4dC5oIGIvaW5jbHVkZS9ody9oZXhhZ29uL2hleGFnb25faG14X2Nv
bnRleHQuaApuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwMDAwMC4uOGRlZDlhZDM4
NWQKLS0tIC9kZXYvbnVsbAorKysgYi9pbmNsdWRlL2h3L2hleGFnb24vaGV4YWdvbl9obXhfY29u
dGV4dC5oCkBAIC0wLDAgKzEsMjQgQEAKKy8qCisgKiBIZXhhZ29uIEhNWCBFeHRlbnNpb24gQ29u
dGV4dCBRT00gT2JqZWN0CisgKgorICogQ29weXJpZ2h0IChjKSBRdWFsY29tbSBUZWNobm9sb2dp
ZXMsIEluYy4gYW5kL29yIGl0cyBzdWJzaWRpYXJpZXMuCisgKiBTUERYLUxpY2Vuc2UtSWRlbnRp
ZmllcjogR1BMLTIuMC1vci1sYXRlcgorICovCisKKyNpZm5kZWYgSEVYQUdPTl9ITVhfQ09OVEVY
VF9ICisjZGVmaW5lIEhFWEFHT05fSE1YX0NPTlRFWFRfSAorCisjaW5jbHVkZSAiaHcvY29yZS9z
eXNidXMuaCIKKyNpbmNsdWRlICJxb20vb2JqZWN0LmgiCisjaW5jbHVkZSAidGFyZ2V0L2hleGFn
b24vaG14X3N0YXRlLmgiCisKKyNkZWZpbmUgVFlQRV9IRVhBR09OX0hNWF9DT05URVhUICJoZXhh
Z29uLWhteC1jb250ZXh0IgorT0JKRUNUX0RFQ0xBUkVfU0lNUExFX1RZUEUoSGV4YWdvbkhNWENv
bnRleHRTdGF0ZSwgSEVYQUdPTl9ITVhfQ09OVEVYVCkKKworc3RydWN0IEhleGFnb25ITVhDb250
ZXh0U3RhdGUgeworICAgIFN5c0J1c0RldmljZSBwYXJlbnRfb2JqOworCisgICAgSG14U3RhdGUg
cmVnczsKK307CisKKyNlbmRpZiAvKiBIRVhBR09OX0hNWF9DT05URVhUX0ggKi8KZGlmZiAtLWdp
dCBhL2h3L2hleGFnb24vaGV4LXN1YnN5cy5jIGIvaHcvaGV4YWdvbi9oZXgtc3Vic3lzLmMKaW5k
ZXggMWU2NTc4MjU1ZWIuLjRkOWE3OWNmZjc0IDEwMDY0NAotLS0gYS9ody9oZXhhZ29uL2hleC1z
dWJzeXMuYworKysgYi9ody9oZXhhZ29uL2hleC1zdWJzeXMuYwpAQCAtMTAsNiArMTAsNyBAQAog
I2luY2x1ZGUgImh3L2hleGFnb24vaGV4LXN1YnN5cy5oIgogI2luY2x1ZGUgImh3L2hleGFnb24v
aGV4YWdvbl9nbG9iYWxyZWcuaCIKICNpbmNsdWRlICJody9oZXhhZ29uL2hleGFnb25faHZ4X2Nv
bnRleHQuaCIKKyNpbmNsdWRlICJody9oZXhhZ29uL2hleGFnb25faG14X2NvbnRleHQuaCIKICNp
bmNsdWRlICJody9oZXhhZ29uL2hleGFnb25fdGxiLmgiCiAjaW5jbHVkZSAiaHcvaW50Yy9oZXgt
bDJ2aWMuaCIKICNpbmNsdWRlICJody90aW1lci9xY3QtcXRpbWVyLmgiCkBAIC0xMjAsNiArMTIx
LDIwIEBAIHN0YXRpYyB2b2lkIGh2eF9jb250ZXh0c19jcmVhdGUoSGV4YWdvbkNvbW1vbk1hY2hp
bmVTdGF0ZSAqaG1zLAogICAgIGhtcy0+bnVtX2h2eF9jdHggPSBuOwogfQogCitzdGF0aWMgdm9p
ZCBobXhfY29udGV4dF9jcmVhdGUoSGV4YWdvbkNvbW1vbk1hY2hpbmVTdGF0ZSAqaG1zLAorICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IHN0cnVjdCBoZXhhZ29uX21hY2hpbmVf
Y29uZmlnICptX2NmZykKK3sKKyAgICBEZXZpY2VTdGF0ZSAqY3R4OworCisgICAgaWYgKCFIRVhB
R09OX0NGR1RBQkxFX0hBU19ITVgoJm1fY2ZnLT5jZmd0YWJsZSkpIHsKKyAgICAgICAgcmV0dXJu
OworICAgIH0KKworICAgIGN0eCA9IHFkZXZfbmV3KFRZUEVfSEVYQUdPTl9ITVhfQ09OVEVYVCk7
CisgICAgb2JqZWN0X3Byb3BlcnR5X2FkZF9jaGlsZChPQkpFQ1QoaG1zKSwgImhteC1jb250ZXh0
IiwgT0JKRUNUKGN0eCkpOworICAgIHN5c2J1c19yZWFsaXplX2FuZF91bnJlZihTWVNfQlVTX0RF
VklDRShjdHgpLCAmZXJyb3JfZmF0YWwpOworfQorCiBzdGF0aWMgRGV2aWNlU3RhdGUgKmNsdXN0
ZXJfY3JlYXRlKEhleGFnb25Db21tb25NYWNoaW5lU3RhdGUgKmhtcykKIHsKICAgICBEZXZpY2VT
dGF0ZSAqY2x1c3RlciA9IHFkZXZfbmV3KFRZUEVfQ1BVX0NMVVNURVIpOwpAQCAtMTY3LDYgKzE4
Miw3IEBAIHZvaWQgaGV4X3N1YnN5c19jcmVhdGUoSGV4YWdvbkNvbW1vbk1hY2hpbmVTdGF0ZSAq
aG1zLAogICAgIGhtcy0+Z2xvYl9yZWdzID0gZ2xvYmFscmVnX2NyZWF0ZShobXMsIG1fY2ZnLCBy
ZXYpOwogICAgIGhtcy0+dGxiID0gdGxiX2NyZWF0ZShobXMsIG1fY2ZnKTsKICAgICBodnhfY29u
dGV4dHNfY3JlYXRlKGhtcywgbV9jZmcpOworICAgIGhteF9jb250ZXh0X2NyZWF0ZShobXMsIG1f
Y2ZnKTsKIH0KIAogdm9pZCBoZXhfc3Vic3lzX2FkZF9jcHUoSGV4YWdvbkNvbW1vbk1hY2hpbmVT
dGF0ZSAqaG1zLCBEZXZpY2VTdGF0ZSAqY3B1KQpkaWZmIC0tZ2l0IGEvaHcvaGV4YWdvbi9oZXhh
Z29uX2hteF9jb250ZXh0LmMgYi9ody9oZXhhZ29uL2hleGFnb25faG14X2NvbnRleHQuYwpuZXcg
ZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwMDAwMC4uZTNlYTdiNzE0NzQKLS0tIC9kZXYv
bnVsbAorKysgYi9ody9oZXhhZ29uL2hleGFnb25faG14X2NvbnRleHQuYwpAQCAtMCwwICsxLDQw
IEBACisvKgorICogSGV4YWdvbiBITVggRXh0ZW5zaW9uIENvbnRleHQgUU9NIE9iamVjdAorICoK
KyAqIENvcHlyaWdodCAoYykgUXVhbGNvbW0gVGVjaG5vbG9naWVzLCBJbmMuIGFuZC9vciBpdHMg
c3Vic2lkaWFyaWVzLgorICogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0
ZXIKKyAqLworCisjaW5jbHVkZSAicWVtdS9vc2RlcC5oIgorI2luY2x1ZGUgImh3L2hleGFnb24v
aGV4YWdvbl9obXhfY29udGV4dC5oIgorCitzdGF0aWMgdm9pZCBoZXhhZ29uX2hteF9jb250ZXh0
X3Jlc2V0X2hvbGQoT2JqZWN0ICpvYmosIFJlc2V0VHlwZSB0eXBlKQoreworICAgIEhleGFnb25I
TVhDb250ZXh0U3RhdGUgKnMgPSBIRVhBR09OX0hNWF9DT05URVhUKG9iaik7CisKKyAgICBtZW1z
ZXQoJnMtPnJlZ3MsIDAsIHNpemVvZihzLT5yZWdzKSk7Cit9CisKK3N0YXRpYyB2b2lkIGhleGFn
b25faG14X2NvbnRleHRfY2xhc3NfaW5pdChPYmplY3RDbGFzcyAqa2xhc3MsCisgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uc3Qgdm9pZCAqZGF0YSkKK3sKKyAg
ICBEZXZpY2VDbGFzcyAqZGMgPSBERVZJQ0VfQ0xBU1Moa2xhc3MpOworICAgIFJlc2V0dGFibGVD
bGFzcyAqcmMgPSBSRVNFVFRBQkxFX0NMQVNTKGtsYXNzKTsKKworICAgIHJjLT5waGFzZXMuaG9s
ZCA9IGhleGFnb25faG14X2NvbnRleHRfcmVzZXRfaG9sZDsKKyAgICBkYy0+dXNlcl9jcmVhdGFi
bGUgPSBmYWxzZTsKK30KKworc3RhdGljIGNvbnN0IFR5cGVJbmZvIGhleGFnb25faG14X2NvbnRl
eHRfaW5mbyA9IHsKKyAgICAubmFtZSA9IFRZUEVfSEVYQUdPTl9ITVhfQ09OVEVYVCwKKyAgICAu
cGFyZW50ID0gVFlQRV9TWVNfQlVTX0RFVklDRSwKKyAgICAuaW5zdGFuY2Vfc2l6ZSA9IHNpemVv
ZihIZXhhZ29uSE1YQ29udGV4dFN0YXRlKSwKKyAgICAuY2xhc3NfaW5pdCA9IGhleGFnb25faG14
X2NvbnRleHRfY2xhc3NfaW5pdCwKK307CisKK3N0YXRpYyB2b2lkIGhleGFnb25faG14X2NvbnRl
eHRfcmVnaXN0ZXJfdHlwZXModm9pZCkKK3sKKyAgICB0eXBlX3JlZ2lzdGVyX3N0YXRpYygmaGV4
YWdvbl9obXhfY29udGV4dF9pbmZvKTsKK30KKwordHlwZV9pbml0KGhleGFnb25faG14X2NvbnRl
eHRfcmVnaXN0ZXJfdHlwZXMpCmRpZmYgLS1naXQgYS9ody9oZXhhZ29uL21lc29uLmJ1aWxkIGIv
aHcvaGV4YWdvbi9tZXNvbi5idWlsZAppbmRleCBmYTViYzVlYjlmMS4uZTdhYmFkMWMyMzQgMTAw
NjQ0Ci0tLSBhL2h3L2hleGFnb24vbWVzb24uYnVpbGQKKysrIGIvaHcvaGV4YWdvbi9tZXNvbi5i
dWlsZApAQCAtMiw2ICsyLDcgQEAgaGV4YWdvbl9zcyA9IHNzLnNvdXJjZV9zZXQoKQogaGV4YWdv
bl9zcy5hZGQoZmlsZXMoJ2hleGFnb25fdGxiLmMnKSkKIGhleGFnb25fc3MuYWRkKGZpbGVzKCdo
ZXhhZ29uX2dsb2JhbHJlZy5jJykpCiBoZXhhZ29uX3NzLmFkZChmaWxlcygnaGV4YWdvbl9odnhf
Y29udGV4dC5jJykpCitoZXhhZ29uX3NzLmFkZChmaWxlcygnaGV4YWdvbl9obXhfY29udGV4dC5j
JykpCiBoZXhhZ29uX3NzLmFkZCh3aGVuOiAnQ09ORklHX0hFWF9EU1AnLCBpZl90cnVlOiBmaWxl
cygnaGV4LXN1YnN5cy5jJykpCiBoZXhhZ29uX3NzLmFkZCh3aGVuOiAnQ09ORklHX0hFWF9EU1An
LCBpZl90cnVlOiBmaWxlcygnaGV4YWdvbl9kc3AuYycpKQogaGV4YWdvbl9zcy5hZGQod2hlbjog
J0NPTkZJR19IRVhfQk9BUkQnLCBpZl90cnVlOiBmaWxlcygnaGV4LWJvYXJkLmMnKSkKLS0gCjIu
MzQuMQoK

