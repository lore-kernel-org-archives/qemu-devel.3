Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2922EA8114
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 13:35:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpnsr-0005f5-JY; Tue, 10 Feb 2026 08:34:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vpnsn-0005e1-0l
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 08:34:25 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vpnsj-0001nd-Nc
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 08:34:24 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61A6jRRr442377
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 13:34:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GexMtmgfGvMqUlr405tGcNusaInSecWFUKDx3/DCuI8=; b=mkJtRSBSlB+8+7pZ
 hmeJZk6inWTkDtR1a+SuX5VzyR9NNZmjjC2gZ+KcH1svuvSe5BFli4q15TfMvbFZ
 awCAutNA9/bArvVMDaD6GYQw+3k1GGJLtqfj8pVpHA7jVDbWlaXhBC//bdIhPID3
 n183vx5wdVkQhXSX1b55GMpTec9vSmu21STpsuSCXw+uwBQ3ScNPxLqznSfAp6vw
 KPH5+DrgkYdQkGOZ/ExD8ebcAyyAam0jFbqMC6jB1E6K5h4mzcGM+IEwHJsaUSwE
 mX3LNXt3mVdt3eXDogJOFlIx/Q3lA1WK1wwwz2HIj3VZdbZztbpg+tn7jn3GYXfh
 R/iiqA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c7qp9jqv0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 13:34:18 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2ba745f54c6so5132967eec.0
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 05:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1770730458; x=1771335258; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GexMtmgfGvMqUlr405tGcNusaInSecWFUKDx3/DCuI8=;
 b=EMhKYVjY0rFijeJi6jW1sSGE+t5ehvgtUo8lXe2Q9mq4NFigBiXKOKGJ/eaKvqlIIp
 vsN0pZ5IC1rgw/9rXSxcs4KsTN6uluzx1D8Y7s8x2UpLXgt1+0+Wx+dWsqw15vrcchW1
 F/2DxxG40NA4J6bZ9NGMN8aY2zmnprSvLHggk+0gvmxbZgWa8h5SWs23f2X5fXX3jtp2
 SSG83bZMkA/tthxxbhUvUTOB1Ioz5yHmf9gV9ycpyGPsnn6fUxRFcH8/B/UoLP6IK3sA
 1l1LNM+dppaip/whiiHL6zpNcUsR8tIsxFnSD32MpTqPLYM/9iYAGJxryW5sl2kI/fRa
 bBTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770730458; x=1771335258;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GexMtmgfGvMqUlr405tGcNusaInSecWFUKDx3/DCuI8=;
 b=P2AwZQZ0PjVZXxLw0FxxVLmRhVuyGtthxZoWtJsLnPKjckkacMvKBOiFpTN6Uc75lH
 2zOCkTJGRkOJK/7k2SXob3XnOxCYYLJppfO/GIs8hzmpbwIBQuvygSTJp3FOQ9BxwsMN
 sHYr85psXerU1UckqizaGuF2UwMogZ4/Fv2+h3rbDnmiKqRZEipHxkE3WS+jrOHzZPpc
 q9Is7UeXHVJfwu8aLMbIAukTKUOdxgFVnbQrbU9PJGvYF6OV0Gt8jJyeSq1omMdw/Vvf
 WzkhD+2QCa4ESN9iQJ+eMQ9au8o3HUfImGSTH5vG6gwQmMvl6SK6rR74hLtf4Anvtsg1
 zvqg==
X-Gm-Message-State: AOJu0YxThM7yJ2DdgyhIuaZGaZ+OiF5cQf99s3mXTJGYYcCb3r1cswMH
 hPV7siSCFZ3PCrmms6fYmCUwoLAK8bIuKzNQkaAyTi5uhM5MLKfTj0mezDOaxk0mrwS6GMyhbUR
 QXXzV3xBenMMX0wbGJ8skh8Ck3lWynGqFEkUaRamDc0nuqD7BC+mS9XXRdAHNqlz8Zg==
X-Gm-Gg: AZuq6aJSO1hUOGMRmqy1cuZurHSTVZtnCEbnynXGPLZN5wbwbQnkledEhAhbyabZwgi
 kTNhFkdix0T10OPF63+0XXbBUBxK5xh15pUDzsb5pUk4hDq0GE4+Dt3V8Zs4Fm9jEi5s8I4yLii
 0DAw07pUpigpTRwuuB4MAWcNtZbmE5n2RQVZjpsVnkWfYcbjNm9kpeBbBbSrFG9om+ZfJ+aGv8I
 Yu/M6fRJ7jCmj1bWsRHK8zNBfXZpYnMrHBcC4hJ/JMo9lAHPuAOewJk+TPjx8/2rkZGltsgUwCz
 FqDZNiNBXqA004phQrT1knmq4nk32JOCP+sor1UIxteCQkf4Fhlm1j0HvUDTrIX1EKD3gt2fmb0
 CRRldMC7ZKoeOl+HH40+ahrS4DxRtG/W+2DtKoBR/51166nNoKUt4wDpE4lqiYprkUagBjQ==
X-Received: by 2002:a05:693c:37c7:b0:2b6:c617:f795 with SMTP id
 5a478bee46e88-2b856486ab7mr6821721eec.17.1770730457955; 
 Tue, 10 Feb 2026 05:34:17 -0800 (PST)
X-Received: by 2002:a05:693c:37c7:b0:2b6:c617:f795 with SMTP id
 5a478bee46e88-2b856486ab7mr6821704eec.17.1770730457442; 
 Tue, 10 Feb 2026 05:34:17 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ba7e149c58sm2716162eec.26.2026.02.10.05.34.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 05:34:17 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com, alex@alexrp.com,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 2/4] target/hexagon: Return decode failure for invalid
 non-duplex encodings
Date: Tue, 10 Feb 2026 05:33:52 -0800
Message-Id: <20260210133355.16093-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260210133355.16093-1-brian.cain@oss.qualcomm.com>
References: <20260210133355.16093-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: 9qw5PkAqcubCNGmDbsp3NtbiKwyMBv0s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDExNCBTYWx0ZWRfX/mTXFx9oHJFX
 rJTthrIPLtfJWU74yjx5rVKVlpVw1xg39DVAHQB8pWwpNnRWiR++IlQQ1XgLhNslMTDxRbW5lzG
 bC867KIO5jNl0VOWPriDy6RoVi5aMXuOTFeAO2/9jZPBPIgQcJ1Lo6CSgjVUMzbve5XovHDU1qz
 eBdbKYy1ikUxUwF+OcV0Nyj0UDJwKpZ4paLoBK16HGNb0/9C/523y4JiOu72ioCXoxH+M6nwK1R
 llJGNm8f63MW3fAW6RKQoGoBNMe/+bM/qRV24QFFnyfDlkiG6aJT1nHmTC9b9QuiBdH10Gf12v6
 wg2Q7EvFUV245EHEvo9e6mFdwe6NPeXK9Ucja1LSVEy6RKdqvsWoL2Mj9LuBxEJfE15sLB+XKkN
 4c8Z3DUQJPUJ79phWfz2XiYr5Og4b693BZmSXYRdlwx6tcMnSrD1eQSr33j3lQzugiwSF4H2cGq
 Ft/LE1TeOAnphxRQypQ==
X-Authority-Analysis: v=2.4 cv=dP2rWeZb c=1 sm=1 tr=0 ts=698b33da cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=KKAkSRfTAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=D67r-eMCZ0zeLs--bqkA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 9qw5PkAqcubCNGmDbsp3NtbiKwyMBv0s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_01,2026-02-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 impostorscore=0 phishscore=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 adultscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602100114
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

V2hlbiBhIG5vbi1kdXBsZXggZW5jb2RpbmcgKHBhcnNlX2JpdHMgIT0gMCkgZmFpbHMgYm90aCBk
ZWNvZGVfbm9ybWFsKCkKYW5kIGRlY29kZV9odngoKSwgdGhlIGRlY29kZXIgaGl0IGFuIHVucmVh
Y2hhYmxlLiAgSW5zdGVhZCwgaGFuZGxlCnRoZSBkZWNvZGUgZmFpbHVyZSBhbmQgcmFpc2UgYW4g
ZXhjZXB0aW9uLgoKUmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZp
ZXJAbGluYXJvLm9yZz4KUmV2aWV3ZWQtYnk6IFRheWxvciBTaW1wc29uIDxsdGF5bG9yc2ltcHNv
bkBnbWFpbC5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1
YWxjb21tLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9kZWNvZGUuYyAgICAgICAgICAgICAgfCAg
MyArKy0KIHRlc3RzL3RjZy9oZXhhZ29uL2ludmFsaWQtZW5jb2RpbmcuYyB8IDI1ICsrKysrKysr
KysrKysrKysrKysrKysrKysKIDIgZmlsZXMgY2hhbmdlZCwgMjcgaW5zZXJ0aW9ucygrKSwgMSBk
ZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2RlY29kZS5jIGIvdGFyZ2V0
L2hleGFnb24vZGVjb2RlLmMKaW5kZXggNjliYTFlYzk2Yy4uMzNhZDYwYzViNCAxMDA2NDQKLS0t
IGEvdGFyZ2V0L2hleGFnb24vZGVjb2RlLmMKKysrIGIvdGFyZ2V0L2hleGFnb24vZGVjb2RlLmMK
QEAgLTQ4OSw3ICs0ODksOCBAQCBkZWNvZGVfaW5zbnMoRGlzYXNDb250ZXh0ICpjdHgsIEluc24g
Kmluc24sIHVpbnQzMl90IGVuY29kaW5nKQogICAgICAgICAgICAgaW5zbi0+aWNsYXNzID0gaWNs
YXNzX2JpdHMoZW5jb2RpbmcpOwogICAgICAgICAgICAgcmV0dXJuIDE7CiAgICAgICAgIH0KLSAg
ICAgICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsKKyAgICAgICAgLyogSW52YWxpZCBub24tZHVw
bGV4IGVuY29kaW5nICovCisgICAgICAgIHJldHVybiAwOwogICAgIH0gZWxzZSB7CiAgICAgICAg
IHVpbnQzMl90IGljbGFzcyA9IGdldF9kdXBsZXhfaWNsYXNzKGVuY29kaW5nKTsKICAgICAgICAg
dW5zaWduZWQgaW50IHNsb3QwX3N1Ymluc24gPSBnZXRfc2xvdDBfc3ViaW5zbihlbmNvZGluZyk7
CmRpZmYgLS1naXQgYS90ZXN0cy90Y2cvaGV4YWdvbi9pbnZhbGlkLWVuY29kaW5nLmMgYi90ZXN0
cy90Y2cvaGV4YWdvbi9pbnZhbGlkLWVuY29kaW5nLmMKaW5kZXggMDEwYTVlYjc0MS4uNjM5ZDdm
MjQ5NSAxMDA2NDQKLS0tIGEvdGVzdHMvdGNnL2hleGFnb24vaW52YWxpZC1lbmNvZGluZy5jCisr
KyBiL3Rlc3RzL3RjZy9oZXhhZ29uL2ludmFsaWQtZW5jb2RpbmcuYwpAQCAtNjUsNiArNjUsMzAg
QEAgc3RhdGljIGludCB0ZXN0X2ludmFsaWRfZHVwbGV4KHZvaWQpCiAgICAgcmV0dXJuIHNpZzsK
IH0KIAorLyoKKyAqIEludmFsaWQgbm9uLWR1cGxleCBlbmNvZGluZzoKKyAqIFRoZSBlbmNvZGlu
ZyAweGZmZmZjMDAwIGhhcyBwYXJzZSBiaXRzIFsxNToxNF0gPSAwYjExLCBtYWtpbmcgaXQgYQor
ICogbm9uLWR1cGxleCBpbnN0cnVjdGlvbiBhbmQgcGFja2V0IGVuZC4gIFRoZSByZW1haW5pbmcg
Yml0cyBkbyBub3QgbWF0Y2gKKyAqIGFueSB2YWxpZCBub3JtYWwgb3IgSFZYIGluc3RydWN0aW9u
IGVuY29kaW5nLCBzbyB0aGlzIHNob3VsZCByYWlzZSBTSUdJTEwuCisgKi8KK3N0YXRpYyBpbnQg
dGVzdF9pbnZhbGlkX25vbmR1cGxleCh2b2lkKQoreworICAgIGludCBzaWc7CisKKyAgICBhc20g
dm9sYXRpbGUoCisgICAgICAgICJyMCA9ICMwXG4iCisgICAgICAgICJyMSA9ICMjMWZcbiIKKyAg
ICAgICAgIm1lbXcoJTEpID0gcjFcbiIKKyAgICAgICAgIi53b3JkIDB4ZmZmZmMwMDBcbiIKKyAg
ICAgICAgIjE6XG4iCisgICAgICAgICIlMCA9IHIwXG4iCisgICAgICAgIDogIj1yIihzaWcpCisg
ICAgICAgIDogInIiKCZyZXN1bWVfcGMpCisgICAgICAgIDogInIwIiwgInIxIiwgIm1lbW9yeSIp
OworCisgICAgcmV0dXJuIHNpZzsKK30KKwogaW50IG1haW4oKQogewogICAgIHN0cnVjdCBzaWdh
Y3Rpb24gYWN0OwpAQCAtNzUsNiArOTksNyBAQCBpbnQgbWFpbigpCiAgICAgYXNzZXJ0KHNpZ2Fj
dGlvbihTSUdJTEwsICZhY3QsIE5VTEwpID09IDApOwogCiAgICAgYXNzZXJ0KHRlc3RfaW52YWxp
ZF9kdXBsZXgoKSA9PSBTSUdJTEwpOworICAgIGFzc2VydCh0ZXN0X2ludmFsaWRfbm9uZHVwbGV4
KCkgPT0gU0lHSUxMKTsKIAogICAgIHB1dHMoIlBBU1MiKTsKICAgICByZXR1cm4gRVhJVF9TVUND
RVNTOwotLSAKMi4zNC4xCgo=

