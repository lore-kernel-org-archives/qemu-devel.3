Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBA9606A31B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 14:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PCnW7E1F;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RvQkPs9J
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLiKl-0001yc-Fv; Tue, 27 Oct 2026 10:39:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xLiKM-0008Oe-3J
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 10:39:05 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xLiKK-0006CJ-Kv
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 10:39:01 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RDnwrf3449400
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 14:38:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JjhyJC4BY3IazM59tbX28jqRvB3ufw+iLOnfFaC7n+k=; b=PCnW7E1FG+sFz94r
 udGl1/N46bOis0MrmRFVxleUgeOrYXe/JYmiwSHwbJSNg2wIY9evW8fIbdBvJIQP
 V1r695M3C9+/RsEOOqTRCTp5PybNYSat4cWKPluHgL9+UGWaUZXSd8VkwBhaT69s
 ZJVPdcp9ZRoJw1MVTqJAYnm2Dxgh6rtpcPO77oU8M3jp9b4oKoz7Qow2U0xc0dHZ
 bNsefoPpUy0WSfMsavd4AlN/jUdc8ySoOocOLX/6jts4k9stj0pGl9g1R0pcU+tO
 Qy1nHRkBX9IMhQfJOBpB9eQHVDMQBeB+48/iW71W6QkobfoUedpX30JhIQR7vczC
 uNNd3g==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjh91b09s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 14:38:59 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3abfcf726dcso6176454a91.2
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 07:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793111939; x=1793716739; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JjhyJC4BY3IazM59tbX28jqRvB3ufw+iLOnfFaC7n+k=;
 b=RvQkPs9JOb3wJSsXeq7TtHD1e3Yjzebrjp5IGIgXjr10jlaLR1wwzKeKT9VhGDuoi9
 AGeoUMVHVrgUJ0YLTZ0MfUJaXJabr6ht/q5D1VCEwNIWA0h0GGyjg1lX1W0a5mTrYEwG
 Y7Aqi56ItteDZKjxjvhs1j8QABkQRnxIYufZ/0XiD+MqJswgpQ38nBCtqQt3OKVraDKy
 nnfv3/R6NhpREwY3Z8xOq2NSS4keCp0lqKqOB9hQnEc7Z3q7duJ9f3/dhZAsGv9EsoJ/
 8b67CFWNwxOBj2SEC28EQZYgC6ugNdqCYyEJbEAYfcm7eLLX1EAknZBBYRW+uCRv+Xbx
 dnaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793111939; x=1793716739;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JjhyJC4BY3IazM59tbX28jqRvB3ufw+iLOnfFaC7n+k=;
 b=A35IUs7yarsncgASl5rtNuk3cksrH6ks22SNoC+1E2S4/jLC3e4QL9AX03Hru3jQVi
 c1YXDAw/8lGw+xRriXrv6V/gPKyL9s3eSZdFuw78Bxtv/W3genabWHxZDySSz+1mvaCH
 3mgqjLc0HDr3C4l4jnYtIZ9XHHO9jmCnMVIS4pkCQWU0FV2ns+NCZSGUK75ZxpZU8NWA
 1d9E25sONeubo7/NWiPlxHQZR8/3kcSTEaIQxv8ezgI4cWYnWCdZoEjabFofi1kyIVkY
 292EmFTNND0jFrO+dtptMAy5yjVtanx0KW1QWtFrkOUhT6xaa67pl1f6AZRUQIBV8vsz
 3OTQ==
X-Gm-Message-State: AFq9FYK/SbFUNdpTokTJTL3IPHl5Jw8V82VH2FQ54muIWiuu8DvJhR8t
 HDK/9EwKlxykZr4LYQj1LentsTrg0D7PPJMr/uCD/hYxa8CU0slZyf6ENby19v0ArcpZk3hzmMR
 iIBpQAwTkylHwlwZnct4nNDtHjy2dRdcGr3eNiAtUOoHM45E+BSgKbAP52Jceg454jA==
X-Gm-Gg: AYBFou0moOYKy5Aod2mbAHoFBPZN/urTH9Yc8g5AwJXjwnjhdn7vaStQT57OYeakGcH
 AJJDC+drEN694aFrI7TogKdF/C1Q+k/KPwKmNa64NqVBoCprfK9f+A9t8ULZyN9JMT1GIrTIBx8
 As6s3V3iKU3NugNdK5J6QYZHqQtV9tdjKKkTACDOYkw9U0yb3bE0u/RLrZEcXjVpBKPa7h6QEdw
 rvxY2J7T01njmIkGArKRuuRJ5OZqj+LCmAwP0rS7PW9ijWdUALkhEjlehZgZSjCKEWUD+f8xIkH
 AjTDZPGl1Yvxih+cd8ym86B0kZ8GPbtEimaJ7Owi77pUpdFrfdDSEn26wbRpcotswRptkMoWAj3
 XLnm11XN079LMKzy5HhIV6AVI6Fr8EV7LXpy6UKCo36ihKNQ=
X-Received: by 2002:a17:90b:5147:b0:3ac:aa8d:19de with SMTP id
 98e67ed59e1d1-3ade9b2ee42mr8500483a91.3.1793111938519; 
 Tue, 27 Oct 2026 07:38:58 -0700 (PDT)
X-Received: by 2002:a17:90b:5147:b0:3ac:aa8d:19de with SMTP id
 98e67ed59e1d1-3ade9b2ee42mr8500464a91.3.1793111938069; 
 Tue, 27 Oct 2026 07:38:58 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae404dde70sm4056102a91.1.2026.10.27.07.38.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 07:38:56 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v4 34/42] target/hexagon: drop a pending HALT when resuming
Date: Tue, 27 Oct 2026 07:37:13 -0700
Message-Id: <20261027143721.4125584-35-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261027143721.4125584-1-brian.cain@oss.qualcomm.com>
References: <20261027143721.4125584-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: fqeuMSfDTM-dYUk4S23lCR3VmHRXX1yB
X-Proofpoint-GUID: fqeuMSfDTM-dYUk4S23lCR3VmHRXX1yB
X-Authority-Analysis: v=2.4 cv=TuxzFzXh c=1 sm=1 tr=0 ts=6ae0b783 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=I2XebtYxRxNeac7nJm4A:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA1OCBTYWx0ZWRfX8vPEqMSWR98M
 YGDXA6N6NgjYJaAj9TE5zF4HAm3o0ZNP1lCH8x+++NGIM9HOvPjd6A21osk05+c2nDvSfESmi2T
 RBLioJfBp6JOx7HRW0HJfJ+uFHizCF8qsEQ/sVh/eJ6eQ0GhWBk990iGj4x4s7LAoUGsaUxPhGM
 iSNAc7JMyenqtcQ2V4+gwrI5NvPPYkCgWt4GWiEldplFMyt2hI0oKW+1CryOlttLuflQjJ3y3QI
 Fjn40SlhG9+ri/3msFf5PMZNQDh0OtF7jvaEbW8fOLmBRyFTXjvIaUU9B8FZ1svzxH2mgD/CODE
 sTfNCN6/cvYgfwQ9Yr4TG7mgdgjiXlF006KOk7LCzZlajvUTDCBnZM1+YhlGDuWOy8YsB6x9Xc/
 +lHlJ5wyw+/LwFupX1XRwYtFZaJ0Ompcu9XrIpfmfAOizLGIY3nPJMgf0HJMudBqA7R6rLyEHye
 8z2bnr16GeJsnqXGlzA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA1OCBTYWx0ZWRfX9b6FR9j203sW
 yF0a7rG8ZBHatQze5j4RK904cDtXjwj7lri3JdDFzS4AhLzm6ijq4iF4fDzkeogpuIj2RJCaxcM
 4vJ5zaboe5y5qo7RLMsmGwC8w7npr/Q=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270058
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

QSB0aHJlYWQgZW50ZXJpbmcgd2FpdCBtb2RlIHJhaXNlcyBDUFVfSU5URVJSVVBUX0hBTFQgb24g
aXRzZWxmIGFuZCBvbmx5CnRha2VzIGl0IG9uY2UgaXRzIFRCIGVuZHMuICBJZiBhbm90aGVyIHRo
cmVhZCByZXN1bWVzIGl0IGluIGJldHdlZW4sIHRoZQpIQUxUIGlzIHN0aWxsIHBlbmRpbmcuCgpD
bGVhciB0aGUgSEFMVCBvbiByZXN1bWUuCgpSZXZpZXdlZC1ieTogUGllcnJpY2sgQm91dmllciA8
cGllcnJpY2suYm91dmllckBvc3MucXVhbGNvbW0uY29tPgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBD
YWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24vY3B1
X2hlbHBlci5jIHwgMSArCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKCmRpZmYgLS1n
aXQgYS90YXJnZXQvaGV4YWdvbi9jcHVfaGVscGVyLmMgYi90YXJnZXQvaGV4YWdvbi9jcHVfaGVs
cGVyLmMKaW5kZXggYzY2YWQ4ODEwOGQuLjkxOWZjYmM3Yzk3IDEwMDY0NAotLS0gYS90YXJnZXQv
aGV4YWdvbi9jcHVfaGVscGVyLmMKKysrIGIvdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5jCkBA
IC05OCw2ICs5OCw3IEBAIHN0YXRpYyB2b2lkIGhleGFnb25fcmVzdW1lX3RocmVhZChDUFVIZXhh
Z29uU3RhdGUgKmVudikKICAgICBjbGVhcl93YWl0X21vZGUoZW52KTsKICAgICBjcyA9IGVudl9j
cHUoZW52KTsKICAgICBBU1NFUlRfRElSRUNUX1RPX0dVRVNUX1VOU0VUKGVudiwgY3MtPmV4Y2Vw
dGlvbl9pbmRleCk7CisgICAgY3B1X3Jlc2V0X2ludGVycnVwdChjcywgQ1BVX0lOVEVSUlVQVF9I
QUxUKTsKICAgICBjcy0+aGFsdGVkID0gZmFsc2U7CiAgICAgY3MtPmV4Y2VwdGlvbl9pbmRleCA9
IEhFWF9FVkVOVF9OT05FOwogICAgIHFlbXVfY3B1X2tpY2soY3MpOwotLSAKMi4zNC4xCgo=

