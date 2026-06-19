Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3EAFCDB466
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 23:05:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waiCR-0003D0-Jf; Fri, 19 Jun 2026 19:00:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waiCB-0002RL-QN
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 19:00:23 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waiC9-0001sL-EH
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 19:00:19 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65JLXdvx1251243
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 23:00:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ohgluABwS6D8saHfHv2eOLCkXGQOTd4JgFhw3pUO1aE=; b=UKuRGX9sBD/+zt4c
 REpcicQIm6X5+RypXEfbFibu3VJiqdb0xa9fLJVu7XiiyPvLiXtRhsNgMq5zfZpi
 1llH98LB8Bmf7oNbCu6XQrWXJussUy1XLp3X/8+Vl1c7h5IibOYOcaWodHaZePRz
 U3seVSFiC1I87b3j63ab5ocJDTUP/W/LuApuTn6KKF3rJ3kzR9iKEVtZiIIIEnwc
 7W49r+k8sEuAt6HkududdVk1d2ENpPsYNT31va4oF+HbIWTe7zJw3KkvYSEU5PCx
 t9ktJvhTn7Tb5U8pg2495S/9ZEdMXlsYEpOJhQVeOpnneCdp8S23XqaZLE+Pg2ER
 qXISUQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ewbgp8n54-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 23:00:05 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30bc5f826f2so4610050eec.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 16:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781910005; x=1782514805; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ohgluABwS6D8saHfHv2eOLCkXGQOTd4JgFhw3pUO1aE=;
 b=GqTPOpyovx2xncYn2UaQRkNYIJQfBQ4iRzKm9v4ZIkpyYPsNO8SnMIA16J9VrPqvlK
 ylA/oKxqsttTczLLWR+ubq3RrWnER95z32dwBFnhiF4xZbpeSyzlOBa2yRJQ/JgQdblQ
 E0LZNQWTj5A/8A/af809qUX3IMqSNNUoiX/zr6mAYvrcjI4nnADkpi2zMaCd7/3Pjrcd
 EL624oTN3cqmASVbcH/x/oMNfjmcwvkha/gqxpqXJuoie8JBput9MwAcXt92vFr5Xk5b
 SAShWwuJj1JOeT4UvnC+Y6Avq0L533DrbRIWVRmA9+/3cI8rop7Zp9ej4aaSoKQCOusU
 PL6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781910005; x=1782514805;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ohgluABwS6D8saHfHv2eOLCkXGQOTd4JgFhw3pUO1aE=;
 b=UzozMJKWujqh8l3411RU6TpV27k+H3Li4PjfUYBm08r363WTY4KepRdA5uTFZv+Mpv
 cwpc429JumXzlFF/wAOrE2KmcLGynwCulYyGUgMHJos5NnTLxd0HtdqrUQKxleHvLcBG
 exJq1fxzvqg6ILwVmWtgvKB5GzhPhqrwhwb9OKMG4F/hRg1TPLqChU3eseUBOtGsBIdg
 o6eOnmsdxKNDuhBscpvWYNySMfrbvyFdO9dVQOMQ6Ba31lveNHDr7ohaSO314TV3a3Dl
 fNUM2pHv4/rBAID7fH/JLaLW0NILG3VBkSJyQONB7WQ/Ob4Dmmvqi5BBe0QYqTzHQC+G
 +xXg==
X-Gm-Message-State: AOJu0Yy7Qkwg65dvH7Uo6H+RzMMPZOdiGZN5yP/Y4+x4qejZuRS6bnjW
 MY1SkAyaCWl7ULqSBotyxpIIqUQNiyM0Q/mmSOJfLNANFzg83T+Z7igJjx1U9blJAWFe0/HUpn2
 WHu0ryZzUecGJh982Ox1BYwNfXr+6PA8ID8eaX0REV0JoA2TYmk+IJ98qSZbbDTRWLA==
X-Gm-Gg: AfdE7cnWlXJBuRnE1vNmk+hk2gR6PQqJ9U1VK1DDY694g/L//oSKchDcbjuvJBeQ1YC
 9AfGCcSEHzJcDcOSDAK49O6bQPI+n3+asTctQ/9CEIpiyv0fi7opzQkTm0pr7c22kgU4/9ViZWQ
 Wu6uuO5iihkpjaFDuzYHhJzikeE8Sr++4EwHgTKQAPqk7cdwLPbcy8OuDLvw3Lj8XQDdZ1GS1/n
 ow3k8yKIJuP5UHcJTJJZHREWbwWrR5u5Tx0R3RqCQpW5rhyHLJ2YsG8aXnzCqMyCblrwEApC04U
 t+Y8wghyYCcc6k4mGPVqdNLkam4TNOYP2mneWVB9z1uM342HiIyNgceadF2sl2Wy8OpusGmwuFj
 haDIi/TItJdrJIhmEJpvq4cbcD3wdQrPLeSytBli243ocIIkB64GQtdXl2fw=
X-Received: by 2002:a05:7300:7fa7:b0:2fc:9d97:d59a with SMTP id
 5a478bee46e88-30c0d17fb0emr2349410eec.32.1781910005340; 
 Fri, 19 Jun 2026 16:00:05 -0700 (PDT)
X-Received: by 2002:a05:7300:7fa7:b0:2fc:9d97:d59a with SMTP id
 5a478bee46e88-30c0d17fb0emr2349388eec.32.1781910004864; 
 Fri, 19 Jun 2026 16:00:04 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1b4f7d81sm1309510eec.0.2026.06.19.16.00.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 16:00:03 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 35/74] target/hexagon: Define f{S,G}ET_FIELD macros
Date: Fri, 19 Jun 2026 15:58:32 -0700
Message-Id: <20260619225911.159473-36-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
References: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: OLClz8mOFXtG-Ax1vHbr_2Gc8zRKwz04
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDIyMCBTYWx0ZWRfXweCU+6Budjdt
 8KW/uOmXqwxUrM5AQBvOLtXqXsXdfjjfCJ8yBrtjz977XkcDjYSBe/xRChwSs4vnGzo10MAtBYu
 Wb/80Dl6bvtTnLkxv0tbFwZ7N7UjenK3J8F6PVPmzB9ZXEU0TkEcj+yr5TVj7WA2r8sQ96/srJj
 siq5A+Th2eoU6GoxcWKXxmJd98u7NPZhin1ZaVm0whvS92NakSYqt2TlTl2f56nIkyDdLxLb5tV
 O1lkzL0wPUVqKe/vktukMQr3tXCmJyqKueCIyYKTTIgUU5DnHVwTQEQ59ffZLeexRnMMk9HMOYT
 DkB5LaweVTmE91bm5JgY9Nwo38316kKL/QQNeI6dwEiWnoIQpHnqsvb9Xk1AL5DO6ViU19O6hcL
 XyIIfextsEavDAYKz0SwGyWOGq/WrLC8vpbG8NfgzVlPSORA1oZbjJVQfA1iXB3FV9tzEZZRwi/
 j7zL1qla9MJLBaucoDg==
X-Proofpoint-GUID: OLClz8mOFXtG-Ax1vHbr_2Gc8zRKwz04
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDIyMCBTYWx0ZWRfXw4bdVfDwruYH
 qWCfngWKb9HMh4n6tej9/YRpA0YwEhWBQdvKzBWTt0mhfEgVF6lNNDAHar5cGbHOxpcmxqON9Y+
 pmDYfCaf2UAvR1ofsDzl5mdKLE3sImY=
X-Authority-Analysis: v=2.4 cv=d8vFDxjE c=1 sm=1 tr=0 ts=6a35c9f5 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=OC-ZKJ6AczBSh3OnBRYA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_05,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0
 impostorscore=0 suspectscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190220
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL21h
Y3Jvcy5oIHwgMTAgKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKykK
CmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9tYWNyb3MuaCBiL3RhcmdldC9oZXhhZ29uL21h
Y3Jvcy5oCmluZGV4IDM4YTQzNjQ3ZGQ5Li4wNDFlNjhhMTUwZSAxMDA2NDQKLS0tIGEvdGFyZ2V0
L2hleGFnb24vbWFjcm9zLmgKKysrIGIvdGFyZ2V0L2hleGFnb24vbWFjcm9zLmgKQEAgLTY1Myw2
ICs2NTMsMTYgQEAgc3RhdGljIGlubGluZSBUQ0d2IGdlbl9yZWFkX2lyZWcoVENHdiByZXN1bHQs
IFRDR3YgdmFsLCBpbnQgc2hpZnQpCiAgICAgICAgICAgICAgICAgICAgcmVnX2ZpZWxkX2luZm9b
RklFTERdLndpZHRoLCBcCiAgICAgICAgICAgICAgICAgICAgcmVnX2ZpZWxkX2luZm9bRklFTERd
Lm9mZnNldCkKIAorI2RlZmluZSBmR0VUX0ZJRUxEKFZBTCwgRklFTEQpIFwKKyAgICBmRVhUUkFD
VFVfQklUUyhWQUwsIFwKKyAgICAgICAgICAgICAgICAgICByZWdfZmllbGRfaW5mb1tGSUVMRF0u
d2lkdGgsIFwKKyAgICAgICAgICAgICAgICAgICByZWdfZmllbGRfaW5mb1tGSUVMRF0ub2Zmc2V0
KQorI2RlZmluZSBmU0VUX0ZJRUxEKFZBTCwgRklFTEQsIE5FV1ZBTCkgXAorICAgIGZJTlNFUlRf
QklUUyhWQUwsIFwKKyAgICAgICAgICAgICAgICAgcmVnX2ZpZWxkX2luZm9bRklFTERdLndpZHRo
LCBcCisgICAgICAgICAgICAgICAgIHJlZ19maWVsZF9pbmZvW0ZJRUxEXS5vZmZzZXQsIFwKKyAg
ICAgICAgICAgICAgICAgKE5FV1ZBTCkpCisKICNpZmRlZiBRRU1VX0dFTkVSQVRFCiAjZGVmaW5l
IGZEQ1pFUk9BKFJFRykgXAogICAgIGRvIHsgXAotLSAKMi4zNC4xCgo=

