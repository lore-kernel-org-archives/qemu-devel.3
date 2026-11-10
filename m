Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B13606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 02:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=aZWHQVSX;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=J0tdUq14
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQbvP-0006O8-KO; Mon, 09 Nov 2026 21:49:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xQbvH-0006KV-1C
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 21:49:23 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xQbvD-0004Bq-Aq
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 21:49:22 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AA0j1dR2481044
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 02:49:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QB2/xR3Q8K7jSKxSx2KxTJZpdoC4R9tsNBVJrws3maM=; b=aZWHQVSXqltw4GsU
 6SdRjt05ya4DzPgKvmsK/UNogRItyiYAfvivayPOpQ5S7JfsNKwRe64W68saBV2C
 LZ534Jyaq6+jsFObamFkxx4abYMoMXzIOXw/N0/jmVqXpgbbLNOHnfMCl2qLeox2
 RZKmAM65BBwXN7FPdemBRkdeINuphOPEe16lKY1FlVeOT1NB64Ku12yllP8ptPql
 frTaHlnWYi9qPLPBqWPOQkW3RYgXTjKGqquSSlhlfxTFyPvw4BGaV8x3HS32xuvf
 +JZhR01ebTaG5ga5Fcl6RbTg1WUBCLC0DSks1/uKDON3213P+E2G67a7bP2HeXfC
 LiHJVg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hufx82j9n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 02:49:16 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-36efb506f29so508662eec.1
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 18:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794278956; x=1794883756; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QB2/xR3Q8K7jSKxSx2KxTJZpdoC4R9tsNBVJrws3maM=;
 b=J0tdUq14Kl2b26lryfkMNmw/nHNivzbgZPMJXGazmsGugUnh4KDT6inEs0VPFHKEQF
 IFjoYDyraiuHBZm2IPm79xgiwBQ+khkxzHaq5EJU4NSI7bsI/KEjkiziXXSMx0B1pc2L
 6NqeOPIJKmTyDUw4fZG/UGroKWp/siTfTMsXTbBWyW/Z78iUjEmZH1eHzWdNSpADcCFH
 eEC0C3ibu5bf0YEFkN9KwGIRET+N5/z3gB5ghjiYayB44bHd4W8hi9ROCR8OcijegCZv
 DbQQuiCiGj3V+lFhvQ0DA/r4/tYmCTKKwQAXQcn33MK5HgeCy4Md+4Nbytlqrg4dsBui
 /O1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794278956; x=1794883756;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QB2/xR3Q8K7jSKxSx2KxTJZpdoC4R9tsNBVJrws3maM=;
 b=x4cGhdvSVC5VDDu+pkeRv1HAQbhqvn4/kj2swG5gxaresQ6GZVccLnZZlC5PyTqp9N
 OCnEncBy+M5ift7LSBgb8/DuN4a4XE30kDskhuIhhMBCDaYYBA8CPF5Xq55dY14OaZkt
 tIl3/d9f9YHwP2dLJRBHk+wV/On+siAx/6vwb64vwn02M9MzdNvZy0sLnRJpuFZnGEVU
 1xfqkEr57V7IA//sHQuvbtQkSYgVWX9om/vGktxxxpbO7Qcw96LhvsSYVRJpOEGIShsh
 Il7XAJer1UhDdsYC5XQj08jJmizSCuHCHV4zHW+ayOM2bdAYUxyYER09HkHGpv3RskZG
 EGIQ==
X-Gm-Message-State: APuU4Z+d76TGfx9F4LxIhnif+QxKlEfw1R4/bH5y1tibx5VlhL7N22Te
 qy3Rns6Fcc5T6HyheuIrQ4jTRaudjOJS6gr3WNU3cfPx/P0gOjOT0nmOZVQ9STnuZ69q78ZuTVi
 ZHWxnsp6yC/HYri3Ug10l3Lax+nfESdM5f6qzbyzXEo5yYRrJPCDl1pNifwuTe8YuRA==
X-Gm-Gg: AYBFou0GygLzxwUtJjyFQtvztrJECyFdVoN8mQSBwNyDcGMZoYDkzqljdjR6EQPNqeH
 XMaKdjOpLqHjeBhuUaFfMk6epjGbD4+VVSzRrI5hDbFUTYo/bXv6fLN1DU4Qgkwg4PbuZpz2fzO
 1pM4AXVzBiL/oE3AhT4O9DIDcp3FvpQkySmkdcoEGHfK7RsoUPepw9AooDa4d5N5n7/BxihdAha
 Vp5Kmq2n0xvwgU1K8iupjnCg08UTY+EdCKSmFopUtozS8GFJCgrpSZ/kX/ml4T2yCNfz20SmdO8
 9Y+lNo97Hme5y091yv5sE3d2QbSxVhJx5GlDS5c0ZMKLb6YtJXwE0Dr9rR+wM/qJU+75nPJKZRB
 1wwd9aanQNZVZB33ci+Y7ZvdVAMngbfmHUArI8XhJDp3J2i/aqGOpgxbER9WFX+2VJjhiO28o0O
 rbr1l24mdzX+DViKQv7g8V
X-Received: by 2002:a05:7301:4d0a:b0:36c:b138:651e with SMTP id
 5a478bee46e88-3751f659239mr1490486eec.22.1794278955645; 
 Mon, 09 Nov 2026 18:49:15 -0800 (PST)
X-Received: by 2002:a05:7301:4d0a:b0:36c:b138:651e with SMTP id
 5a478bee46e88-3751f659239mr1490451eec.22.1794278954983; 
 Mon, 09 Nov 2026 18:49:14 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-375212e9d78sm2700263eec.25.2026.11.09.18.49.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 18:49:14 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Marco Liebel <marco.liebel@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 01/11] target/hexagon: preserve guest event fault and CFI state
Date: Mon,  9 Nov 2026 18:48:51 -0800
Message-Id: <20261110024901.1610588-2-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261110024901.1610588-1-brian.cain@oss.qualcomm.com>
References: <20261110024901.1610588-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=AbYkjHXG c=1 sm=1 tr=0 ts=6af2862c cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=Y-XEI8Yr0LQOVZ0TCh0A:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: ZCYraRY_QXx_27NBooHTcwSEx1ff3qZZ
X-Proofpoint-ORIG-GUID: ZCYraRY_QXx_27NBooHTcwSEx1ff3qZZ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAxMCBTYWx0ZWRfX1Lg/pxjlCn+Q
 Snq2cZaLVwS4e2WKrSbCWCVjAkZCbMew8sRoLlXr2ETl0rtxUGiSrUuptb6kCUBVbyiK/xVn9zp
 NvDq8ProRbqzuLRNAjPQbMqKpQ9r9E8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAxMCBTYWx0ZWRfXwM725IOE9rGZ
 m3/yOVP6jPlw/Fn02Yse/F0/fkTQHa8EXg6TNj6oa7ND3O+FCz+2lKFwHzr96altwv1wekU4y+K
 zKDXDESMJLNeWY6qSOV2WOuoe//uChnCLeg08JIwXEAj5TVRlQ4m1W96OtHFY/v/sFH0SqyyVsS
 zHutnZTBeH39ohk0nRi9JpWqRh78ozl0oUAte4cfAUQUsVmeJKPDIyQ31+7CX3U8X3eHj1jQtld
 8X6FgxkG1rNBEGGlqAIjdF/OSCyUhew0PXDzokExMy3lqKehS7HmmCpsNb75pi9xhxi+SOJ6j80
 u5rJFh3dXtOm/CbpDY84DDUdLfOAl6D2wcBYNESiQTKyuztpY1G/U/ImAaj+p+0mk6DWCPKuhuf
 /m3KDb7gTSFuP33HDUUk07W48PJfiol9+u+KKACMaM4PBWuMx3UyOCs8jaP6xE2H8IBeU5fn9AK
 +/FGZq5bIxYoYPOc6sw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_01,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 bulkscore=0 spamscore=0 clxscore=1015 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611100010
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

RnJvbTogTWFyY28gTGllYmVsIDxtYXJjby5saWViZWxAb3NzLnF1YWxjb21tLmNvbT4KCkd1ZXN0
IGV2ZW50IGVudHJ5IG11c3Qgc2VsZWN0IEJBRFZBMCBvciBCQURWQTEgdGhyb3VnaCBTU1IuQlZT
Cmluc3RlYWQgb2YgY29weWluZyB0aGUgc3RhbGUgQkFEVkEgYXJyYXkgc2xvdC4gSXQgbXVzdCBh
bHNvIHNhdmUKU1NSLkNGSSBpbnRvIEdTUi5DRkkgc28gZ3Vlc3QgcmV0dXJuIGNhbiByZXN0b3Jl
IHRoZSBpbnRlcnJ1cHRlZApDRkkgc3RhdGUuCgpTaWduZWQtb2ZmLWJ5OiBNYXJjbyBMaWViZWwg
PG1hcmNvLmxpZWJlbEBvc3MucXVhbGNvbW0uY29tPgpSZXZpZXdlZC1ieTogQnJpYW4gQ2FpbiA8
YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxi
cmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24vaGV4c3dpLmMg
fCA2ICsrKysrLQogMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigt
KQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2hleHN3aS5jIGIvdGFyZ2V0L2hleGFnb24v
aGV4c3dpLmMKaW5kZXggNjYzZDlmZTQ5ZWEuLmYyMmQ0YTc3NTE2IDEwMDY0NAotLS0gYS90YXJn
ZXQvaGV4YWdvbi9oZXhzd2kuYworKysgYi90YXJnZXQvaGV4YWdvbi9oZXhzd2kuYwpAQCAtODA5
LDYgKzgwOSw5IEBAIHN0YXRpYyB2b2lkIGd1ZXN0X2V2ZW50X2VudHJ5KENQVUhleGFnb25TdGF0
ZSAqZW52LCB1aW50MzJfdCBjYXVzZSwKICAgICBnc3IgPSBkZXBvc2l0MzIoZ3NyLCByZWdfZmll
bGRfaW5mb1tHU1JfSUVdLm9mZnNldCwKICAgICAgICAgICAgICAgICAgICAgcmVnX2ZpZWxkX2lu
Zm9bR1NSX0lFXS53aWR0aCwKICAgICAgICAgICAgICAgICAgICAgR0VUX0ZJRUxEKENDUl9HSUUs
IGVudi0+dF9zcmVnW0hFWF9TUkVHX0NDUl0pKTsKKyAgICBnc3IgPSBkZXBvc2l0MzIoZ3NyLCBy
ZWdfZmllbGRfaW5mb1tHU1JfQ0ZJXS5vZmZzZXQsCisgICAgICAgICAgICAgICAgICAgIHJlZ19m
aWVsZF9pbmZvW0dTUl9DRkldLndpZHRoLAorICAgICAgICAgICAgICAgICAgICBHRVRfRklFTEQo
U1NSX0NGSSwgb2xkX3NzcikpOwogICAgIGVudi0+Z3JlZ1tIRVhfR1JFR19HU1JdID0gZ3NyOwog
ICAgIFNFVF9TWVNURU1fRklFTEQoZW52LCBIRVhfU1JFR19TU1IsIFNTUl9TUywgMCk7CiAgICAg
U0VUX1NZU1RFTV9GSUVMRChlbnYsIEhFWF9TUkVHX1NTUiwgU1NSX0dNLCAxKTsKQEAgLTgxNiw3
ICs4MTksOCBAQCBzdGF0aWMgdm9pZCBndWVzdF9ldmVudF9lbnRyeShDUFVIZXhhZ29uU3RhdGUg
KmVudiwgdWludDMyX3QgY2F1c2UsCiAgICAgU0VUX1NZU1RFTV9GSUVMRChlbnYsIEhFWF9TUkVH
X0NDUiwgQ0NSX0dJRSwgMCk7CiAgICAgZW52LT5ncmVnW0hFWF9HUkVHX0dFTFJdID0gZXZlbnRf
cGM7CiAgICAgaWYgKHNldF9nYmFkdmEpIHsKLSAgICAgICAgZW52LT5ncmVnW0hFWF9HUkVHX0dC
QURWQV0gPSBlbnYtPnRfc3JlZ1tIRVhfU1JFR19CQURWQV07CisgICAgICAgIGVudi0+Z3JlZ1tI
RVhfR1JFR19HQkFEVkFdID0gZW52LT50X3NyZWdbCisgICAgICAgICAgICBHRVRfRklFTEQoU1NS
X0JWUywgb2xkX3NzcikgPyBIRVhfU1JFR19CQURWQTEgOiBIRVhfU1JFR19CQURWQTBdOwogICAg
IH0KICAgICBlbnYtPmdwcltIRVhfUkVHX1BDXSA9IGdldmIgKyB2ZWNfb2Zmc2V0OwogfQotLSAK
Mi4zNC4xCgo=

