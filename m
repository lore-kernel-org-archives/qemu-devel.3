Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D4C606A31D
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 22:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KeReZfV6;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bPr5fKa5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMumK-0000dn-Uu; Fri, 30 Oct 2026 18:08:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMumI-0000d1-VI
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 18:08:50 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMumF-0003pN-U4
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 18:08:50 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69ULtcrK3948865
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 22:08:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Ap/eiC6BAtCEQ58cjHVOwTFZankQmoNBpnTZ2yMeOIs=; b=KeReZfV6+M4RqPx1
 lj77F96vR2LCZDOgM+RlvjvWB/o8CQKTQrw5DkK54iHpOtP/zxTt9CkmWPSQFwB2
 Qh/eK+OG8vq+aUBWu7NN+ShZn1zXqSaWlnwtBMiCgKM2OL8o+KmieceMUXDZXSwR
 yiUtF+oTbWhQ5MXZNTQbIouwP5dfsR30OecTgHZp6uuwbWzgfvFVEwzicgAusth9
 hv0OlSzKewp/PTCqE/LDdCAW69OhxaU1ra13Rg5AFq0wMw3ouEUEl55cAg5hl/uu
 0iz9CqwRG2X/164RaneyUffqSDhpAc6a1bspOtt0pAjILZ54+xIkzxe4Dt36V2US
 rUW1tA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn2x185as-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 22:08:46 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-35c3c370b17so1978239eec.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 15:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793398125; x=1794002925; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ap/eiC6BAtCEQ58cjHVOwTFZankQmoNBpnTZ2yMeOIs=;
 b=bPr5fKa53HQl3FE52rXUvs9fKUznBnhbQivt1AV0k7T4JsFcjzYm6SKzR0tzDr2iGY
 1+LSDVgupPk1+hbBjLKI4lUzSJ+mMzYR2jVhG8cfgKPnmgXpfwx9ANDqMTk1kUer42pF
 MGmk1bGgvwRdGxC6Ut0rnlHWczu5SrLHCNNmwE1LerGEr0zOB+yysVdj863fU2riK+l7
 Kc+pBSRG4Q4zCU7fR8/Djr5NdCJ75mBAhl2LaT6i/bKMjUWuScNOTNkh2W18rh1zcZKc
 uUecfwwI0X0nNog51v3MD7mc2i6SucmYk8FmAakAPtSq9Hpgrd5Rn/cuqQAMHQGr75GH
 rfEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793398125; x=1794002925;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ap/eiC6BAtCEQ58cjHVOwTFZankQmoNBpnTZ2yMeOIs=;
 b=wKA8BzBdDyRHfUxRGOdAEbfyBFXpr/ti64lCcf2ytNJRLonUIQIUqYMRX1pH7in6O7
 FtJoQyNF9YXrz1T/bEGlEpA23N9bFfCNOT04/JB+w3p4/Ak5CS2XpKiY4nimH/pZXTSI
 b1EvpBDNhqPDw/Zfsuo5RCaswC5xD6+raiXLdcOyLPq8pO9Vbl7GNfOhY42QTOS5rF9m
 bRTTGR/GQjutqnYdg3aZ9GbISPHIbiUxoJh4O9ECcKFh87HKIH9Xcd1wko9SElpPGshJ
 roZ8iPkMnctQ037LSN7cHZZYaKDGrN7ICOu6jc2WeeDrinruSIMAjQlysmH0S0A7Ig4g
 tCEw==
X-Gm-Message-State: AFq9FYJwMRORusi8KLGgZxBJ+Od1XRL5XcLxk+ipAcfmdYZEQkF98fAK
 kk3/gqrBtJh9qmYajBOdnTwO6OLG9WhpSJq+OzKGdXSs/4EOAQUX/m5qZ6hFkT4qN6PRBszkc6S
 B1da8RMez4rVd0ZJi+wj7lJKVLfN3Y0K/gZMynwn8M4n0dYCCC9MZNA+FojEIbN9ZOA==
X-Gm-Gg: AYBFou0eFL1WMjB88RWkbU7m7hATnDFlcnjpk1SjwOUS75pwKB0XKkrIeErdn6MB1Ez
 Hm/MMnjnFKEVZ8u8RhwwRRZMbgsJWzUB3igSIch8cziKTgAEt6o3JpnTi+sColMaoOnrXrmbw77
 h5+CSwD4Qe90SNtSmobvmXQNaj0nKbbhEAq34w3sc9dOX1MKs1rPSRRdupbRo+D4GAecE7h8y83
 +LTrEL694n47RCfUX939mThr4oUPTDUMonk29t0aYFyfwK6qDeSjgDfp32KiO6stvaqHR4k2GsH
 lf1klXkpPIOSESstApnXe9F9F6HilXMirg1kOa71U+jIDMz549RK4Ogiml/UhOzclW72h8ZChuz
 U0EBJEXXcGKgVUIbZT+RypCaZhJ1ALK2lEvONm8jk84maDSQ8C1778QPbq3HMB3aZg4SoIg5JwX
 DKwY1mr0ItuHM/+0dbTboN
X-Received: by 2002:a05:7301:7e14:b0:367:363f:6fe4 with SMTP id
 5a478bee46e88-36a423f6947mr4655863eec.32.1793398125412; 
 Fri, 30 Oct 2026 15:08:45 -0700 (PDT)
X-Received: by 2002:a05:7301:7e14:b0:367:363f:6fe4 with SMTP id
 5a478bee46e88-36a423f6947mr4655825eec.32.1793398124751; 
 Fri, 30 Oct 2026 15:08:44 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a429467cdsm9965691eec.19.2026.10.30.15.08.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 15:08:43 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alessandro Di Federico <ale@rev.ng>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>, Anton Johansson <anjo@rev.ng>
Subject: [PATCH v3 1/8] target/hexagon: add HMX attrs, state
Date: Fri, 30 Oct 2026 15:08:33 -0700
Message-Id: <20261030220840.4142885-2-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261030220840.4142885-1-brian.cain@oss.qualcomm.com>
References: <20261030220840.4142885-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: cujHKmJxL-NKqT5ir_MDjCysqh0iOGDJ
X-Proofpoint-ORIG-GUID: cujHKmJxL-NKqT5ir_MDjCysqh0iOGDJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA4OCBTYWx0ZWRfX8O+FJtLDg9wW
 PkfppzKr+1HDv/tj5s6PIL7OIJuhm08r1B9Qsf/0OLdnBAxuxgmsYIjBN0N4lmd8tQWa9COiT51
 EUvPWOaK6iduDUdKjpclwgHdn4lpUuFbxR97X3hf28fJ5j1Nf4Ac6bqP8qKXjT7iEWZSDw+zTSt
 CeYU5DkxcrVv77VbOEpoxWF/PqmfGhDNLgy/kjaSIXQa9/JmDb8V/BEcYhyG0Fqz0bllzLtFGUJ
 DZkJ9TK9yGJvBVBewc7yHxjULtpa0LId7yfXJ0qPI4oeFUJzRWOi5VTxJrPDu+cpM8RcCu+fZVo
 glFgLDpLioXCyJJEJwXHclH+LwADQGNpnslnK2kytZSyO+UvgYAaxX4yAXv8B2kK4h3IvrJ+5fr
 BtEC6xyjbMF0HjZCsbpL2DR6Hc6Dta4HOL1HcfeFMO4OHDV5jbl4UYm5h+KXsVVL/jyg9sbMRyj
 p9HHapKulLXFOdXTIXg==
X-Authority-Analysis: v=2.4 cv=R92WitRX c=1 sm=1 tr=0 ts=6ae5156e cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=eIqSBVWmwaVrM3dqyzoA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA4OCBTYWx0ZWRfX4kS7VHcQjV9C
 /MqV1ka/7oe3Ufaf+ndXHSwtUeW8P2adBTvyEr+rgHPHxTZlphhodPRpOU1CQOGzYEhYx40Cdp8
 bdNZ7LLS5hWL6YsvCA6W8aVAC0aSkh4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_07,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2610300088
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

QWRkIGluc3QgYXR0cmlidXRlcyBmb3IgSE1YIGFuZCBzdGF0ZSBkZWZpbml0aW9uLgoKUmV2aWV3
ZWQtYnk6IE1hcmNvIExpZWJlbCA8bWFyY28ubGllYmVsQG9zcy5xdWFsY29tbS5jb20+ClNpZ25l
ZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0
YXJnZXQvaGV4YWdvbi9obXhfc3RhdGUuaCAgICAgICB8IDkyICsrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrCiB0YXJnZXQvaGV4YWdvbi9hdHRyaWJzX2RlZi5oLmluYyB8IDEzICsrKysr
CiAyIGZpbGVzIGNoYW5nZWQsIDEwNSBpbnNlcnRpb25zKCspCiBjcmVhdGUgbW9kZSAxMDA2NDQg
dGFyZ2V0L2hleGFnb24vaG14X3N0YXRlLmgKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9o
bXhfc3RhdGUuaCBiL3RhcmdldC9oZXhhZ29uL2hteF9zdGF0ZS5oCm5ldyBmaWxlIG1vZGUgMTAw
NjQ0CmluZGV4IDAwMDAwMDAwMDAwLi40M2M4Y2JkOWUwNwotLS0gL2Rldi9udWxsCisrKyBiL3Rh
cmdldC9oZXhhZ29uL2hteF9zdGF0ZS5oCkBAIC0wLDAgKzEsOTIgQEAKKy8qCisgKiBIZXhhZ29u
IEhNWCAoTWF0cml4IGVYdGVuc2lvbnMpIFN0YXRlIERlZmluaXRpb25zCisgKgorICogQ29weXJp
Z2h0IChjKSBRdWFsY29tbSBUZWNobm9sb2dpZXMsIEluYy4gYW5kL29yIGl0cyBzdWJzaWRpYXJp
ZXMuCisgKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRlcgorICovCisK
KyNpZm5kZWYgSEVYQUdPTl9ITVhfU1RBVEVfSAorI2RlZmluZSBIRVhBR09OX0hNWF9TVEFURV9I
CisKKyNkZWZpbmUgSE1YX1NQQVRJQUxfRElNX0ZYUCAgICAgNjQKKyNkZWZpbmUgSE1YX1NQQVRJ
QUxfRElNX0ZQICAgICAgMzIKKyNkZWZpbmUgSE1YX09VVFBVVF9DSEFOTkVMUyAgICAgMzIKKyNk
ZWZpbmUgSE1YX05VTV9BQ0NfU0VUUyAgICAgICAgMgorI2RlZmluZSBITVhfTlVNX0NWVF9BR0VT
ICAgICAgICAzCisjZGVmaW5lIEhNWF9OVU1fQklBU19TRVRTICAgICAgIDQKKworI2RlZmluZSBI
TVhfQUNUX0NST1VUT05fU0laRSAgICAyMDQ4CisjZGVmaW5lIEhNWF9BQ1RfQ0FDSEVfU0laRSAg
ICAgICgyICogSE1YX0FDVF9DUk9VVE9OX1NJWkUpCisKK3R5cGVkZWYgc3RydWN0IEhteEFjY0Z4
cCB7CisgICAgaW50MzJfdCBkYXRhW0hNWF9TUEFUSUFMX0RJTV9GWFBdW0hNWF9PVVRQVVRfQ0hB
Tk5FTFNdOworfSBIbXhBY2NGeHA7CisKKy8qIEZQIGFjY3VtdWxhdG9yIGNlbGwgc3RvcmFnZTog
SUVFRSBiaW5hcnk2NCBiaXQgcGF0dGVybnMgKi8KK3R5cGVkZWYgc3RydWN0IEhteEFjY0ZwIHsK
KyAgICB1aW50NjRfdCBkYXRhW0hNWF9TUEFUSUFMX0RJTV9GUF1bSE1YX09VVFBVVF9DSEFOTkVM
U107Cit9IEhteEFjY0ZwOworCit0eXBlZGVmIHN0cnVjdCBIbXhBY2NTZXQgeworICAgIEhteEFj
Y0Z4cCBmeHBfcHJpbWFyeTsKKyAgICBIbXhBY2NGcCAgZnBfcHJpbWFyeTsKK30gSG14QWNjU2V0
OworCit0eXBlZGVmIHN0cnVjdCBIbXhDdnRTdGF0ZUZ4cCB7CisgICAgdWludDE2X3QgZGF0YVtI
TVhfU1BBVElBTF9ESU1fRlhQXVtITVhfT1VUUFVUX0NIQU5ORUxTXTsKK30gSG14Q3Z0U3RhdGVG
eHA7CisKKy8qIEZQIGNvbnZlcnQgc2xvdDogb25lIEZQMTYgdmFsdWUsIG9yIGFuIEZQOCBieXRl
IHBlciBzcGF0aWFsIGhhbGYgKi8KK3R5cGVkZWYgc3RydWN0IEhteEN2dFN0YXRlRnAgeworICAg
IHVpbnQxNl90IGRhdGFbSE1YX1NQQVRJQUxfRElNX0ZQXVtITVhfT1VUUFVUX0NIQU5ORUxTXTsK
K30gSG14Q3Z0U3RhdGVGcDsKKwordHlwZWRlZiBzdHJ1Y3QgSG14U3RhdGUgeworICAgIEhteEFj
Y1NldCBhY2NbSE1YX05VTV9BQ0NfU0VUU107CisKKyAgICBIbXhDdnRTdGF0ZUZ4cCBjdnRfZnhw
W0hNWF9OVU1fQ1ZUX0FHRVNdOworICAgIEhteEN2dFN0YXRlRnAgIGN2dF9mcFtITVhfTlVNX0NW
VF9BR0VTXTsKKworICAgIEhteEN2dFN0YXRlRnhwIGN2dF9mdXR1cmVfZnhwOworCisgICAgdWlu
dDY0X3QgYmlhc19yYXdbSE1YX05VTV9CSUFTX1NFVFNdW0hNWF9PVVRQVVRfQ0hBTk5FTFNdOwor
CisgICAgdWludDMyX3QgY3VycmVudF9hY2Nfc2V0OworCisgICAgdWludDhfdCBhY3RfYnVmZmVy
W0hNWF9BQ1RfQ0FDSEVfU0laRV07CisKKyAgICB1aW50MzJfdCBhY3RfcnM7CisgICAgdWludDMy
X3QgYWN0X3R5cGU7CisgICAgdWludDhfdCAgaXNfZjhfb2RkOyAgICAgLyogUnNbMF06IEZQOCBh
Y3RpdmF0aW9uIHJlYWRzIG9kZCBieXRlIG9mIHBhaXIgKi8KKyAgICB1aW50OF90ICBmcDhfb2Rk
X3NlbDsgICAvKiBjdnQgUnNbMTFdOiBGUDggY29udmVydCB3cml0ZXMgb2RkICgxKSBoYWxmICov
CisKKyAgICB1aW50MzJfdCBmb3JtYXRfb2Zmc2V0OyAgICAgLyogU009MiwgRE09MCAqLworICAg
IHVpbnQzMl90IHRpbGVfeF9tYXNrOworICAgIHVpbnQzMl90IHRpbGVfeV9tYXNrOworICAgIHVp
bnQzMl90IHRpbGVfeF9pbmM7CisgICAgdWludDMyX3QgdGlsZV95X2luYzsKKyAgICB1aW50MzJf
dCBmeDsKKyAgICB1aW50MzJfdCBmeTsKKyAgICBpbnQzMl90ICBjaF9zdGFydDsgICAgICAgICAg
LyogcHJlLWNvbXB1dGVkIGNoYW5uZWwgc3RhcnQgKHJhdykgKi8KKyAgICBpbnQzMl90ICBjaF9z
dG9wOyAgICAgICAgICAgLyogcHJlLWNvbXB1dGVkIGNoYW5uZWwgc3RvcCAoZXhjbHVzaXZlKSAq
LworICAgIHVpbnQzMl90IHlfc3RhcnQ7CisgICAgdWludDMyX3QgeV9zdG9wOworICAgIHVpbnQz
Ml90IHlfZGlsYXRlOworICAgIHVpbnQzMl90IGJsb2NrczsKKyAgICBpbnQzMl90ICBkWTsgICAg
ICAgICAgICAgICAgLyogb2Zmc2V0IHRvIHNlY29uZCBhY3RpdmF0aW9uIGNyb3V0b24gKi8KKyAg
ICB1aW50MzJfdCBncm91cF9jb252OyAgICAgICAgLyogY2hfc3RhcnQgPiBjaF9zdG9wICovCisg
ICAgdWludDMyX3QgZ3JvdXBfc2l6ZTsKKyAgICB1aW50MzJfdCBncm91cF9jb3VudDsKKworICAg
IGludDMyX3QgIG1hY19jeWNsZV9saW1pdDsKKworICAgIC8qIERlZmVycmVkIENWVCBwaXBlbGlu
ZSBjb21taXQsIGF0IHRoZSBuZXh0IGNvbnN1bWVyIG9yIGVuZCBvZiBwYWNrZXQgKi8KKyAgICB1
aW50MzJfdCBjdnRfZnhwX3BlbmRpbmc7ICAgICAgLyogMSA9IGZ1dHVyZSBoYXMgdW5jb21taXR0
ZWQgZGF0YSAqLworICAgIHVpbnQzMl90IGN2dF9meHBfcGVuZGluZ19hZ2U7ICAvKiAxID0gcGlw
ZWxpbmUgc2hvdWxkIGFnZSBhdCBjb21taXQgKi8KKworICAgIC8qIERlZmVycmVkIGFjY3VtdWxh
dG9yIGNsZWFyL2ZsaXAsIGF0IHBhY2tldCBlbmQgb3IgbmV4dCBhY2N1bXVsYXRvciB1c2UgKi8K
KyAgICB1aW50MzJfdCBjdnRfYWNjX2NsZWFyX3BlbmRpbmc7CisgICAgdWludDMyX3QgY3Z0X2Fj
Y19jbGVhcl9zZXQ7Cit9IEhteFN0YXRlOworCisjZW5kaWYgLyogSEVYQUdPTl9ITVhfU1RBVEVf
SCAqLwpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vYXR0cmlic19kZWYuaC5pbmMgYi90YXJn
ZXQvaGV4YWdvbi9hdHRyaWJzX2RlZi5oLmluYwppbmRleCA5NmFkMWZkMmY4ZS4uNDM5YTI2OGI1
OTEgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2F0dHJpYnNfZGVmLmguaW5jCisrKyBiL3Rh
cmdldC9oZXhhZ29uL2F0dHJpYnNfZGVmLmguaW5jCkBAIC0yMTAsNSArMjEwLDE4IEBAIERFRl9B
VFRSSUIoSFZYX0lFRUVfRlBfT1VUXzMyLCAiSFZYIElFRUUgRlAgMzItYml0IG91dHB1dCIsICIi
LCAiIikKIERFRl9BVFRSSUIoQ1ZJX1ZYX05PX1RNUF9MRCwgIkhWWCBtdWx0aXBseSB3aXRob3V0
IHRtcCBsb2FkIiwgIiIsICIiKQogREVGX0FUVFJJQihIVlhfRkxULCAiVGhpcyBhIGZsb2F0aW5n
IHBvaW50IEhWWCBpbnN0cnVjdGlvbi4iLCAiIiwgIiIpCiAKK0RFRl9BVFRSSUIoU0hBUkVEX0VY
VEVOU0lPTiwgIlNoYXJlZCBleHRlbnNpb24gaW5zdHJ1Y3Rpb24iLCAiIiwgIiIpCitERUZfQVRU
UklCKEVBX1JFR19PTkxZLCAiRUEgPSBpbnB1dCByZWdpc3RlciBvbmx5IiwgIiIsICIiKQorREVG
X0FUVFJJQihFQV9QQUdFQ1JPU1MsICJFQSBjYWxjdWxhdGlvbiBjYW4gaGF2ZSBhIFBhZ2UgQ3Jv
c3MgU3RhbGwiLCAiIiwgIiIpCitERUZfQVRUUklCKE1QWSwgIkhhcyBhIG11bHRpcGx5IiwgIiIs
ICIiKQorREVGX0FUVFJJQihQQUlSXzFPRjIsICJGb3IgYXNzZW1ibGVyIiwgIiIsICIiKQorREVG
X0FUVFJJQihQQUlSXzJPRjIsICJGb3IgYXNzZW1ibGVyIiwgIiIsICIiKQorREVGX0FUVFJJQihI
TVgsICJITVggY29wcm9jZXNzb3IgaW5zdHJ1Y3Rpb24iLCAiIiwgIiIpCitERUZfQVRUUklCKEhN
WF9DVlQsICJITVggY29udmVydCBpbnN0cnVjdGlvbiIsICIiLCAiIikKK0RFRl9BVFRSSUIoSE1Y
X0ZMVCwgIkhNWCBmbG9hdGluZy1wb2ludCBpbnN0cnVjdGlvbiIsICIiLCAiIikKK0RFRl9BVFRS
SUIoSE1YX0NVX1NDQUxBUiwgIkhNWCBzY2FsYXIgb3BlcmFuZCIsICIiLCAiIikKK0RFRl9BVFRS
SUIoSE1YX0JMT0NLX0FMSUdOLCAiSE1YIGJsb2NrLWFsaWduZWQgYWNjZXNzIiwgIiIsICIiKQor
REVGX0FUVFJJQihITVhfMTI4Ql9BTElHTiwgIkhNWCAxMjgtYnl0ZSBhbGlnbmVkIGFjY2VzcyIs
ICIiLCAiIikKKwogLyogS2VlcCB0aGlzIGFzIHRoZSBsYXN0IGF0dHJpYnV0ZTogKi8KIERFRl9B
VFRSSUIoWlpfTEFTVEFUVFJJQiwgIkxhc3QgYXR0cmlidXRlIGluIHRoZSBmaWxlIiwgIiIsICIi
KQotLSAKMi4zNC4xCgo=

