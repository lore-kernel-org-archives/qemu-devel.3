Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1BE606A31C
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 01:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PqOX43MT;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Wrqi0326
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMxwd-0006Tg-UB; Fri, 30 Oct 2026 21:31:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMxwJ-0005bR-0K
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 21:31:27 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMxwG-000396-TL
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 21:31:22 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69V1BwpK3871731
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2026 01:31:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 P+t/DXNFk18cOqBKxVq2rdf09nvruqbP4JBDn8L8gpk=; b=PqOX43MTnYVo3aKu
 cQqZv8KsqKvb6S5LgH4l7cgm7QBLh+kDP9GT95dy9qRy/NYkpNqov3ErHCy9S4HG
 ztVnMf7+waW96hcNR7USW8rGv8Fg+H8hBJHgmnRxiU0xwyI6HeKFoGXMZmDZTE1F
 twL4GG/vqAHIS1JQ5RTEYhwfMXazrBYnWo9Dmy+n5DpVhReDprZyKAonhVUcEqQI
 bQq6XqFWk9BFP9Om5Gxf0IM5CSq4M6Qy5+pFNqh2FN3hMah054hAHIPfBur3e8A6
 IAmBlC4H8lr4Ho5tq30JYyr7Oh0mbw+Y06XnxCLmUAoY3Xh+A0jbptvTNYOdgcif
 g3xBhQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn2x08jx5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2026 01:31:09 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3662e7a9299so4918859eec.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 18:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793410269; x=1794015069; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=P+t/DXNFk18cOqBKxVq2rdf09nvruqbP4JBDn8L8gpk=;
 b=Wrqi0326BRll1+ZiPLTAo0wpurjpXcntG45pxVfIlI5ow2Q1t2NDkFKMpkKRXSixDc
 Jq43zgZBlQptUFUEExP6b0obDX/+J1DbhIrIE6TpsS09vyRu0bVP89zVzZwkl+i4vCGS
 GHeUD9hljbvlr0Fff3pm3glvO3KP3INuqj6TUE5v2TqtgBd7vysxN9If02LEqv0rObUO
 SFlUWAgCjGJuQNfc8TavMHPhf/hefC0qvyLNsoDNcvCGfs1x9D6zwVLyJcCti8REsZUa
 QJtuz8tE0qYkcaiB98chNx44wRp3ylB9wpI/x9GUpYcwAFojcRataOP8C+amQdKmyn3I
 slnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793410269; x=1794015069;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=P+t/DXNFk18cOqBKxVq2rdf09nvruqbP4JBDn8L8gpk=;
 b=KUBkvReGnAx3+B2oNHDJjvftxE48EYjrq0+O4VMs0M/tarqZK0+cf1Z0kjsBg6aPPz
 duDLBG5uHv2bfHB/OrkBIvBbcix8bX5BL/4YsnrsprBHlXRJ6j3tX2S13OxHW0VYiQzh
 mpgv+l/cm3CsjuP2iRHlkiwRRhWB9TYWWrUPdHYIdK3CvLh4UMvmx19KCyXwXEGYHct7
 3TnH/50j32MGW+tpkCWkJCBbPwwDnj2ikQdnfWTMcW0nJgN4aivZChXUPX9mZGiYHWJr
 z+titJhEvZBwA9jFaQE/xBWY1mXMBJOkIWkZ4LvqXCJ1bF0RlNmg6egI2eh0lhbJKiC+
 MB+Q==
X-Gm-Message-State: AFq9FYLGc4ui4PG0z6x9GOzgVEQpdrQLY0ugAwsuSxDiTGcmKYdItbEg
 /XxClYW1sQM2iMQNyZx0rc8B3ZkFdpDpJnHcRKtRZ0M7oXEcu9oWi6Nqh6UTIiHiwucwLXCM+cU
 1/GXQZGGHTMCLWdP3r6VhLDXbG08H95jJ/pHFLGqHiJeH4NlIUwD2ePaiADkgg1HDdw==
X-Gm-Gg: AYBFou1rsUL2SrRfLKr17X/jCoTSM2vG1I3MmspVPDPIP67RBeDuV2bFuRWGZDm9K3b
 3PsTpu9eEfkbBszrFwseAGOlZ0cmgf0UipuZXacnmHc6RHxVA6R1Eo8XBScU0ReQ9orxZuq3zvQ
 29VND2bC00A9k1rIwBY6qqh5KZKIpGVw4r0xjMkTMWVq/jfgbGVQ2pE1I06HkVmiZLvo57IFvzg
 f3G4A6OqdRGr3BLF6suODS7VmuE0pK9yupmClbWpBldtK+EqisNd2MQm/Eh9ncLnChYQSGwmFLn
 z2dbAEMi+npT97OTIg+H9KCNl+sh76zJEbJO9J7QGC5NhES8el89FY7fISKZYaFnlJ/q+1fALel
 G4/AlZfvjjqDEu8sykV0aLmry6ral6I7TxZ+IsQby4t119u8223a/7G9YbdHDY9kG0G8jsusLN8
 Gf47nYpBl/XA5qy2RBANCQlA==
X-Received: by 2002:a05:7301:619b:10b0:36a:1d6f:917c with SMTP id
 5a478bee46e88-36a423c3380mr6179520eec.22.1793410268468; 
 Fri, 30 Oct 2026 18:31:08 -0700 (PDT)
X-Received: by 2002:a05:7301:619b:10b0:36a:1d6f:917c with SMTP id
 5a478bee46e88-36a423c3380mr6179470eec.22.1793410267583; 
 Fri, 30 Oct 2026 18:31:07 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a42952e1csm12170472eec.20.2026.10.30.18.31.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 18:31:07 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Marco Liebel <marco.liebel@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 37/40] target/hexagon: gate HMX exec on SSR:XE2
Date: Fri, 30 Oct 2026 18:29:38 -0700
Message-Id: <20261031012941.339141-38-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261031012941.339141-1-brian.cain@oss.qualcomm.com>
References: <20261031012941.339141-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: hl_f3kH9DnEZ3hJK0fwqFqroYOqdNi0y
X-Proofpoint-GUID: hl_f3kH9DnEZ3hJK0fwqFqroYOqdNi0y
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMxMDAwNSBTYWx0ZWRfXwA/cKIUczqGV
 qx8OJjFcM8pyqvmqSMHuwW783DZYbUbZ4h8llyFN5AFWCdbO+3oU9ik5qfLLmBZq106fWDgA+0H
 NReykNCMJsVYCIwVJSvaXpCY+/+Tjsw=
X-Authority-Analysis: v=2.4 cv=WfKZ+EhX c=1 sm=1 tr=0 ts=6ae544dd cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=OCf9wL_4i7BUJax0SAUA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMxMDAwNSBTYWx0ZWRfX6vqV/ZHcNMy7
 4QGecKpRT/X3KUbT1OCTEaOE/BeNmWOtmcRWCIKmhlKRaLBvQyTVoT1NnlyHsTSA5MrNykVellT
 Th9NRFPp21GUoAUGelX4MTePIJ5Df1gqiRCKz3WxvLI3azAIWWxyNiaJh/E0ZvCA8bOdKsNOcoM
 VLLgHszb+evVZlQ0ENLbuXX8Iv+UEWMUTlC/PPRv0hUuhL1XXvUULHXm5OE6sDWWswNStO65eI0
 Ee0tTqeGTHahWtj2umPxEyNKmci/HUNmUadq+xjf23Co48Bull73WAEuH8Je1C4/a4O3QEefntj
 ffz71QrB/jBzv/PviEkdZ1fHFNyRpM/X05DMD5a8qNRLN1gYUo7oPp0HvqclaCvSKd6PVqnWBwu
 hAsT3FSNPruvtABGhxqcjLp6rc23sC3vr9YrNu+Vy6gYNsV9uE5ccYDJ6RP50OUmH/BumbUbPqi
 FQd4b/i/V1hckusXfEw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-31_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2610310005
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

RXhlY3V0aW5nIGFuIEhNWCBpbnN0cnVjdGlvbiB3aXRoIFNTUjpYRTIgY2xlYXIgcmFpc2VzIGEg
Tk9fQ09QUk9DMl9FTkFCTEUKZXhjZXB0aW9uLgoKTG9nIHBhY2tldHMgb25lIGFzIExPR19VTklN
UCBmb3Igbm93LgoKUmV2aWV3ZWQtYnk6IE1hcmNvIExpZWJlbCA8bWFyY28ubGllYmVsQG9zcy5x
dWFsY29tbS5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1
YWxjb21tLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9jcHUuaCAgICAgICAgICAgICAgICAgICAg
ICB8ICAxICsKIHRhcmdldC9oZXhhZ29uL2luc24uaCAgICAgICAgICAgICAgICAgICAgIHwgIDEg
KwogdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmggICAgICAgICAgICAgICAgfCAgMiArKwogdGFy
Z2V0L2hleGFnb24vY3B1LmMgICAgICAgICAgICAgICAgICAgICAgfCAgMyArKysKIHRhcmdldC9o
ZXhhZ29uL2RlY29kZS5jICAgICAgICAgICAgICAgICAgIHwgIDMgKysrCiB0YXJnZXQvaGV4YWdv
bi90cmFuc2xhdGUuYyAgICAgICAgICAgICAgICB8IDIxICsrKysrKysrKysrKysrKysrKysrKwog
dGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL3Rlc3Rfc3lzdGVzdHMucHkgfCAgMyArKysKIDcgZmls
ZXMgY2hhbmdlZCwgMzQgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29u
L2NwdS5oIGIvdGFyZ2V0L2hleGFnb24vY3B1LmgKaW5kZXggYjI5MzFiMDkzMjkuLjU3MzkyNTRm
MWY2IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9jcHUuaAorKysgYi90YXJnZXQvaGV4YWdv
bi9jcHUuaApAQCAtMjcxLDYgKzI3MSw3IEBAIEZJRUxEKFRCX0ZMQUdTLCBNTVVfSU5ERVgsIDEs
IDMpCiBGSUVMRChUQl9GTEFHUywgSFZYX0NPUFJPQ19FTkFCTEVELCA1LCAxKQogRklFTEQoVEJf
RkxBR1MsIENQVV9NT0RFLCA2LCAyKQogRklFTEQoVEJfRkxBR1MsIFNTX0FDVElWRSwgOCwgMSkK
K0ZJRUxEKFRCX0ZMQUdTLCBITVhfQ09QUk9DX0VOQUJMRUQsIDE1LCAxKQogCiBHX05PUkVUVVJO
IHZvaWQgaGV4YWdvbl9yYWlzZV9leGNlcHRpb25fZXJyKENQVUhleGFnb25TdGF0ZSAqZW52LAog
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50MzJfdCBleGNl
cHRpb24sCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9pbnNuLmggYi90YXJnZXQvaGV4YWdv
bi9pbnNuLmgKaW5kZXggY2ZkNDA3MjY2OTIuLjBkZDM2ZDI5MzFkIDEwMDY0NAotLS0gYS90YXJn
ZXQvaGV4YWdvbi9pbnNuLmgKKysrIGIvdGFyZ2V0L2hleGFnb24vaW5zbi5oCkBAIC03MSw2ICs3
MSw3IEBAIHN0cnVjdCBQYWNrZXQgewogICAgIGJvb2wgcGt0X2hhc19zY2FsYXJfc3RvcmVfczE7
CiAKICAgICBib29sIHBrdF9oYXNfaHZ4OworICAgIGJvb2wgcGt0X2hhc19obXg7CiAgICAgSW5z
biAqdmhpc3RfaW5zbjsKICAgICBib29sIHBrdF9oYXNfaGx4OwogCmRpZmYgLS1naXQgYS90YXJn
ZXQvaGV4YWdvbi90cmFuc2xhdGUuaCBiL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5oCmluZGV4
IGZhN2U2MjcyMDA1Li5iYzNiNDlhYjA2ZCAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vdHJh
bnNsYXRlLmgKKysrIGIvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmgKQEAgLTExMiw2ICsxMTIs
OCBAQCB0eXBlZGVmIHN0cnVjdCBEaXNhc0NvbnRleHQgewogICAgIERFQ0xBUkVfQklUTUFQKGxy
ZWdzX3VwZGF0ZWQsIE5VTV9MUkVHUyk7CiAgICAgREVDTEFSRV9CSVRNQVAobHJlZ3NfbXVsdGlf
d3JpdGUsIE5VTV9MUkVHUyk7CiAgICAgREVDTEFSRV9CSVRNQVAobHJlZ3NfdXBkYXRlZF90bXAs
IE5VTV9MUkVHUyk7CisgICAgYm9vbCBobXhfY29wcm9jX2VuYWJsZWQ7CisgICAgYm9vbCBobXhf
Y2hlY2tfZW1pdHRlZDsKIH0gRGlzYXNDb250ZXh0OwogCiBib29sIGlzX2dhdGhlcl9zdG9yZV9p
bnNuKERpc2FzQ29udGV4dCAqY3R4KTsKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2NwdS5j
IGIvdGFyZ2V0L2hleGFnb24vY3B1LmMKaW5kZXggNzQ2YWE5OTMyMjAuLjM1NzViMzFkMTk2IDEw
MDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9jcHUuYworKysgYi90YXJnZXQvaGV4YWdvbi9jcHUu
YwpAQCAtMzk2LDYgKzM5Niw5IEBAIHN0YXRpYyBUQ0dUQkNQVVN0YXRlIGhleGFnb25fZ2V0X3Ri
X2NwdV9zdGF0ZShDUFVTdGF0ZSAqY3MpCiAgICAgaGV4X2ZsYWdzID0gRklFTERfRFAzMihoZXhf
ZmxhZ3MsIFRCX0ZMQUdTLCBTU19BQ1RJVkUsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICBH
RVRfU1NSX0ZJRUxEKFNTUl9TUywgZW52LT50X3NyZWdbSEVYX1NSRUdfU1NSXSkgJiYKICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGdldF9jcHVfbW9kZShlbnYpICE9IEhFWF9DUFVfTU9ERV9N
T05JVE9SKTsKKyAgICBoZXhfZmxhZ3MgPSBGSUVMRF9EUDMyKGhleF9mbGFncywgVEJfRkxBR1Ms
IEhNWF9DT1BST0NfRU5BQkxFRCwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgIGNwdS0+aG14
ICYmCisgICAgICAgICAgICAgICAgICAgICAgICAgICBHRVRfU1NSX0ZJRUxEKFNTUl9YRTIsIGVu
di0+dF9zcmVnW0hFWF9TUkVHX1NTUl0pKTsKICNlbHNlCiAgICAgaGV4X2ZsYWdzID0gRklFTERf
RFAzMihoZXhfZmxhZ3MsIFRCX0ZMQUdTLCBNTVVfSU5ERVgsIE1NVV9VU0VSX0lEWCk7CiAjZW5k
aWYKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2RlY29kZS5jIGIvdGFyZ2V0L2hleGFnb24v
ZGVjb2RlLmMKaW5kZXggMGMzZGM2N2UxMmMuLmQ0ODYzMGRhODdkIDEwMDY0NAotLS0gYS90YXJn
ZXQvaGV4YWdvbi9kZWNvZGUuYworKysgYi90YXJnZXQvaGV4YWdvbi9kZWNvZGUuYwpAQCAtODI4
LDExICs4MjgsMTQgQEAgaW50IGRlY29kZV9wYWNrZXQoRGlzYXNDb250ZXh0ICpjdHgsIGludCBt
YXhfd29yZHMsIGNvbnN0IHVpbnQzMl90ICp3b3JkcywKICAgICBwa3QtPmVuY29kX3BrdF9zaXpl
X2luX2J5dGVzID0gd29yZHNfcmVhZCAqIDQ7CiAgICAgcGt0LT5wa3RfaGFzX2h2eCA9IGZhbHNl
OwogICAgIHBrdC0+cGt0X2hhc19obHggPSBmYWxzZTsKKyAgICBwa3QtPnBrdF9oYXNfaG14ID0g
ZmFsc2U7CiAgICAgZm9yIChpID0gMDsgaSA8IG51bV9pbnNuczsgaSsrKSB7CiAgICAgICAgIHBr
dC0+cGt0X2hhc19odnggfD0KICAgICAgICAgICAgIEdFVF9BVFRSSUIocGt0LT5pbnNuW2ldLm9w
Y29kZSwgQV9DVkkpOwogICAgICAgICBwa3QtPnBrdF9oYXNfaGx4IHw9CiAgICAgICAgICAgICBH
RVRfQVRUUklCKHBrdC0+aW5zbltpXS5vcGNvZGUsIEFfSExYKTsKKyAgICAgICAgcGt0LT5wa3Rf
aGFzX2hteCB8PQorICAgICAgICAgICAgR0VUX0FUVFJJQihwa3QtPmluc25baV0ub3Bjb2RlLCBB
X0hNWCk7CiAgICAgfQogCiAgICAgLyoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL3RyYW5z
bGF0ZS5jIGIvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMKaW5kZXggY2UwZjIxNTIzMDguLjAx
NWYwOTU4ZmQwIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYworKysgYi90
YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYwpAQCAtOTE5LDYgKzkxOSwyNCBAQCBzdGF0aWMgdm9p
ZCBnZW5fc3RhcnRfcGFja2V0KERpc2FzQ29udGV4dCAqY3R4KQogICAgICAgICB9CiAgICAgfQog
I2VuZGlmCisKKyAgICBpZiAoY3R4LT5wa3QucGt0X2hhc19obXgpIHsKKyAgICAgICAgZm9yIChp
ID0gMDsgaSA8IGN0eC0+cGt0Lm51bV9pbnNuczsgaSsrKSB7CisgICAgICAgICAgICBpZiAoR0VU
X0FUVFJJQihjdHgtPnBrdC5pbnNuW2ldLm9wY29kZSwgQV9ITVgpKSB7CisgICAgICAgICAgICAg
ICAgcWVtdV9sb2dfbWFzayhMT0dfVU5JTVAsICInJXMnIGlzIG5vdCBpbXBsZW1lbnRlZFxuIiwK
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG9wY29kZV9uYW1lc1tjdHgtPnBrdC5pbnNu
W2ldLm9wY29kZV0pOworICAgICAgICAgICAgfQorICAgICAgICB9CisgICAgfQorCisjaWZuZGVm
IENPTkZJR19VU0VSX09OTFkKKyAgICAvKiBITVggbmVlZHMgU1NSOlhFMiAqLworICAgIGlmIChj
dHgtPnBrdC5wa3RfaGFzX2hteCAmJiAhY3R4LT5obXhfY29wcm9jX2VuYWJsZWQgJiYKKyAgICAg
ICAgIWN0eC0+aG14X2NoZWNrX2VtaXR0ZWQpIHsKKyAgICAgICAgZ2VuX3ByZWNpc2VfZXhjZXB0
aW9uKEhFWF9DQVVTRV9OT19DT1BST0MyX0VOQUJMRSwgY3R4LT5wa3QucGMpOworICAgICAgICBj
dHgtPmhteF9jaGVja19lbWl0dGVkID0gdHJ1ZTsKKyAgICB9CisjZW5kaWYKIH0KIAogYm9vbCBp
c19nYXRoZXJfc3RvcmVfaW5zbihEaXNhc0NvbnRleHQgKmN0eCkKQEAgLTE1NTYsNiArMTU3NCw5
IEBAIHN0YXRpYyB2b2lkIGhleGFnb25fdHJfaW5pdF9kaXNhc19jb250ZXh0KERpc2FzQ29udGV4
dEJhc2UgKmRjYmFzZSwKICAgICAgICAgY3R4LT5iYXNlLm1heF9pbnNucyA9IDE7CiAgICAgICAg
IGN0eC0+aXNfdGlnaHRfbG9vcCA9IGZhbHNlOwogICAgIH0KKyAgICBjdHgtPmhteF9jb3Byb2Nf
ZW5hYmxlZCA9CisgICAgICAgIEZJRUxEX0VYMzIoaGV4X2ZsYWdzLCBUQl9GTEFHUywgSE1YX0NP
UFJPQ19FTkFCTEVEKTsKKyAgICBjdHgtPmhteF9jaGVja19lbWl0dGVkID0gZmFsc2U7CiAjZW5k
aWYKIH0KIApkaWZmIC0tZ2l0IGEvdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL3Rlc3Rfc3lzdGVz
dHMucHkgYi90ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9zeXN0ZXN0cy5weQppbmRleCBm
YjFkMjQ1NGZkMS4uNzZlMjQ4MGMxZDMgMTAwNzU1Ci0tLSBhL3Rlc3RzL2Z1bmN0aW9uYWwvaGV4
YWdvbi90ZXN0X3N5c3Rlc3RzLnB5CisrKyBiL3Rlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi90ZXN0
X3N5c3Rlc3RzLnB5CkBAIC05Niw2ICs5Niw5IEBAIGRlZiB0ZXN0X3N3aV90b3VjaF9tZW1vcnko
c2VsZik6CiAgICAgICAgICIiIkEgc2VtaWhvc3RpbmcgcmVhZCByZXN0YXJ0cyBhZnRlciBhIGZh
dWx0IG9uIGl0cyBzZWNvbmQgcGFnZS4iIiIKICAgICAgICAgc2VsZi5ydW5fZXhpdF96ZXJvKCJz
d2lfdG91Y2hfbWVtb3J5IikKIAorICAgIGRlZiB0ZXN0X2ludmFsaWRfaG14KHNlbGYpOgorICAg
ICAgICBzZWxmLnJ1bl9leGl0X3plcm8oImludmFsaWRfaG14IikKKwogICAgIGRlZiB0ZXN0X2R0
Z19pbnRlcnJ1cHQoc2VsZik6CiAgICAgICAgIHNlbGYucnVuX2V4aXRfemVybygiZHRnX2ludGVy
cnVwdCIpCiAKLS0gCjIuMzQuMQoK

