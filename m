Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DFC606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 03:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TMutgn+B;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OupXyZyZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLXt1-0002A7-8x; Mon, 26 Oct 2026 23:30:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xLXsn-00028f-OU
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 23:29:54 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xLXsm-0008Iv-5r
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 23:29:53 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69R2FKqB867642
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 03:29:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mC8jl7vyVvYi+vhoijubMe1xPjMvd4/tlNPZMUbwGZ8=; b=TMutgn+BwbnGydb9
 ajlSWELmbJmJCgbT1a3/1vmmP2f2YQP/uXRmXlypwj2aOOGuYtVnXydHVlYJXx98
 PAesmoqOgrlFTa7WyrH0Z0AcziLOPLBMYqPaaitgejFnP2+RtDBQkhDUM//SWMVP
 elnsMyc6SebYLBVp11PqYxmwqFzXvYjh7KfvpMmjHDSCAePh0IQbEXTBG211qkV9
 xx60mYk8Ty3jtYXUTHkje4IGs4pW7j/usp+YbkY4TH0wOzDGoP1u1dTOwbSOkp/f
 pN+I10p86s0RpgVTYvLTfDfRUlhsig9d5IsedicjdJY/9HlvT/hR3U1xNICtEi/j
 sEgIOw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj79xtw3e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 03:29:50 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-3425098ae4bso693972eec.0
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 20:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793071790; x=1793676590; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mC8jl7vyVvYi+vhoijubMe1xPjMvd4/tlNPZMUbwGZ8=;
 b=OupXyZyZm7A7TMIdyUfyEFQGwbo09RSpEdFCGHPeYG6RRWtnzJGzaPfKAkBr7T/KtU
 06QAiSNUGukMBzHd6BqIIWxoAnPiGj2XuV9ZunKuFDLl42WK3yYfEamdKXvg3WADL4Qk
 2iCpc/ENQxYiuOwfhhPZIsO0WyoByc3sUHVc5eO3JHto+3q9hdQz86Q7FWvXt1IOiT7u
 w6547QAbPIbM7Ttwp3gqkWf8AmT45V3UU/jXK6rvX0caYQsgslStXDQQOPRJPtI19KQh
 tHvUjMl+ITRoTtEkH5dE0moY7VPRPD3R9UOxA1V+jkdDOKNmuwbtsMBWTstqjlBSaHFR
 LbFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793071790; x=1793676590;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mC8jl7vyVvYi+vhoijubMe1xPjMvd4/tlNPZMUbwGZ8=;
 b=w1vVS6JBsHIpQUz5Fqmf9LC2FSJn3aJMSXO06hj3xsv/iEMQCcCnirbHegoqH5bwwB
 Z8/90Bao4Ixce2lPuYd7lEhP7goKokgnzlGp6n2Pro+uBei+dic02hzt+t8RwiWF7wKk
 ViikeJ+jtuxebSECHbCA3NJDFHJ4TtX73ykOst3agmKlldO7mmXvuwydRjR59W3Veur1
 4ALrCcpTV8mWpMUwuQNZ4id7b0LZ/8e/MX1au7DQa9eWT91abOk8vD4SXooU/8LetI4I
 dODVvHEUGx921TddWglMrzhLSMX+r6XkB9HWoElYR+BKn4P/9AtRYh3v7+OIWj9kMJwt
 1Mjg==
X-Gm-Message-State: AFq9FYIg7iVNjm1LQRcJ2siRx0aX4S9YCzGGkV697ehKuzhZ51Pp2988
 xyj9uVJO4rfZmG+insGigPnfvB1Vp9C+tyD4xpdtpOHgINoeXvpscow9UXbmO/61fQ0cejO8p/U
 qOAJEx+iPflbnYWs+zy6nv64MqnS1/FUAj9920AMVSyUWw2RFG2cydcc1Rm554WLMwQ==
X-Gm-Gg: AYBFou2Tm1hn7+wL14Dnh+CWXI0948HrCja2/3jLNgvFCWapm3/RAhmp/jGrtHXl1Ka
 bXLNo6/0lBTMN9rlssUlxRCSxAsFX18/v90ZT/0FGkbNME4fyGow1c+G4+WeYvFwnPgpYky5GJP
 069WqEFKxSUBzoUgiKmzL+nR26ao0cwvFp07iwEHf9vysDpmAVLp3cSimJQcxJpFs2/u/HZ+/fr
 1pJikAk+k8md5T58Fw+n7O2B+ckGvDAEPZ4JHZFX5bw63w+T/TjZhIfsaL/iYEvbdSZj0YOOXiI
 sFWVFW8RlkMmza31brRYdedoXTPCS/IInVcpReeN/KuxEgGQUrp6r7bfRwOQD8upFoWshAEVXcI
 zXBqPLFAwZvnnfLJco9NH9xhexRZDhATsj24P74yg2CMOgjM=
X-Received: by 2002:a05:701b:450e:20b0:146:5f73:d45b with SMTP id
 a92af1059eb24-1a3c3240343mr1855101c88.3.1793071790162; 
 Mon, 26 Oct 2026 20:29:50 -0700 (PDT)
X-Received: by 2002:a05:701b:450e:20b0:146:5f73:d45b with SMTP id
 a92af1059eb24-1a3c3240343mr1855080c88.3.1793071789550; 
 Mon, 26 Oct 2026 20:29:49 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-19886f790e4sm28479637c88.0.2026.10.26.20.29.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 20:29:48 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>
Subject: [PULL v3 07/41] linux-user/hexagon: report ISA HWCAP through v85
Date: Mon, 26 Oct 2026 20:28:53 -0700
Message-Id: <20261027032927.3055166-8-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261027032927.3055166-1-brian.cain@oss.qualcomm.com>
References: <20261027032927.3055166-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: D_1E6hOVZDzG91Lsku6gi0yWZIpbLvCY
X-Proofpoint-GUID: D_1E6hOVZDzG91Lsku6gi0yWZIpbLvCY
X-Authority-Analysis: v=2.4 cv=FPyOVOos c=1 sm=1 tr=0 ts=6ae01aae cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=RcCyqxnK1iORyYYg75cA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDAxMyBTYWx0ZWRfX1z+aiO4zQQhk
 GxeT4RC6lP4vv1WZW6Xwq08MOmvlUxsPna81vSWkmQXgXblPG+WdLLyd50umZGcE96bkUCyw76J
 HXZXou6xk/3/mi2Hp+mrFQbu6UdPylQzyVSlu+TiaPXrhxnDx4qgfFVnFezibY+S5uv5gyATTc+
 KzRuyL2dLqULyRdH3FqF0Y62ddjSYnTH3zHaINGtwqjhW4S0IgohSUcXmodCKMkzxtkPCy7CUjq
 qqeOPYhS9OuAkDcbtROZVaMRmkUjHGF41tA3EBJSoJcWdiLO0pduLhl6IZ0vY3fe0mvNzpkT0dK
 sP8Zh4SqnNMa2QWEtvU14rxchUCIOJezW+5DzirWMgU2hgiMfOGQCOc1E2cZT88/nnOtJ+P4OgI
 WixZeXCayxE70Bqz9w2phCaMOIIyWsVrzKWHDeVvXbMwQOvd+xe3tyilbWIeglulT4PsSpuYvDK
 aaW3FulX/yhyrdyj3wg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDAxMyBTYWx0ZWRfXxuvNqlai6STb
 /UE9qIkWmLS0BM5p5XtBiHz4qlylYn5NzwCgiip3Gox9oEU+/UOsmb6Cp5onmjrOA0bbGMCwq6t
 HrVJjrAcZ2WlLZQhyHvxGUW4C1z7VHY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 adultscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270013
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

UmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAb3NzLnF1YWxj
b21tLmNvbT4KUmV2aWV3ZWQtYnk6IE1hcmNvIExpZWJlbCA8bWFyY28ubGllYmVsQG9zcy5xdWFs
Y29tbS5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxj
b21tLmNvbT4KLS0tCiBsaW51eC11c2VyL2hleGFnb24vdGFyZ2V0X2VsZi5oIHwgMiArKwogbGlu
dXgtdXNlci9oZXhhZ29uL2VsZmxvYWQuYyAgICB8IDYgKysrKysrCiAyIGZpbGVzIGNoYW5nZWQs
IDggaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2xpbnV4LXVzZXIvaGV4YWdvbi90YXJnZXRf
ZWxmLmggYi9saW51eC11c2VyL2hleGFnb24vdGFyZ2V0X2VsZi5oCmluZGV4IDkwZTUwMzJkNWFh
Li5iMWViNWVhNTAzNyAxMDA2NDQKLS0tIGEvbGludXgtdXNlci9oZXhhZ29uL3RhcmdldF9lbGYu
aAorKysgYi9saW51eC11c2VyL2hleGFnb24vdGFyZ2V0X2VsZi5oCkBAIC00Myw2ICs0Myw4IEBA
IGVudW0gewogICAgIEhXQ0FQX0hFWEFHT05fSVNBX1Y3NyAgICAgICAgICAgPSAxNiwKICAgICBI
V0NBUF9IRVhBR09OX0lTQV9WNzkgICAgICAgICAgID0gMTcsCiAgICAgSFdDQVBfSEVYQUdPTl9J
U0FfVjgxICAgICAgICAgICA9IDE4LAorICAgIEhXQ0FQX0hFWEFHT05fSVNBX1Y4MyAgICAgICAg
ICAgPSAxOSwKKyAgICBIV0NBUF9IRVhBR09OX0lTQV9WODUgICAgICAgICAgID0gMjAsCiAgICAg
SFdDQVBfSEVYQUdPTl9IVlggICAgICAgICAgICAgICA9IDEgPDwgNywKICAgICBIV0NBUF9IRVhB
R09OX0NBQkFDICAgICAgICAgICAgID0gMSA8PCA4LAogICAgIEhXQ0FQX0hFWEFHT05fSFZYX0xF
TkdUSF8xMjhCICAgPSAxIDw8IDksCmRpZmYgLS1naXQgYS9saW51eC11c2VyL2hleGFnb24vZWxm
bG9hZC5jIGIvbGludXgtdXNlci9oZXhhZ29uL2VsZmxvYWQuYwppbmRleCA5Zjk4YWQ4ZmI4Ni4u
ZGIwYmYyOTljYzAgMTAwNjQ0Ci0tLSBhL2xpbnV4LXVzZXIvaGV4YWdvbi9lbGZsb2FkLmMKKysr
IGIvbGludXgtdXNlci9oZXhhZ29uL2VsZmxvYWQuYwpAQCAtNjIsNiArNjIsMTIgQEAgYWJpX3Vs
b25nIGdldF9lbGZfaHdjYXAoQ1BVU3RhdGUgKmNzKQogICAgIGNhc2UgSEVYX1ZFUl9WODE6CiAg
ICAgICAgIGh3Y2FwcyA9IEhXQ0FQX0hFWEFHT05fSVNBX1Y4MTsKICAgICAgICAgYnJlYWs7Cisg
ICAgY2FzZSBIRVhfVkVSX1Y4MzoKKyAgICAgICAgaHdjYXBzID0gSFdDQVBfSEVYQUdPTl9JU0Ff
VjgzOworICAgICAgICBicmVhazsKKyAgICBjYXNlIEhFWF9WRVJfVjg1OgorICAgICAgICBod2Nh
cHMgPSBIV0NBUF9IRVhBR09OX0lTQV9WODU7CisgICAgICAgIGJyZWFrOwogICAgIGRlZmF1bHQ6
CiAgICAgICAgIHJldHVybiAwOwogICAgIH0KLS0gCjIuMzQuMQoK

