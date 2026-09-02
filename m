Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5012C624D0
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 04:45:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1cou-0000dw-U7; Wed, 02 Sep 2026 00:43:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x1cot-0000aW-GI
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 00:43:31 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x1cor-0000Np-Mj
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 00:43:31 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 681KTBTc3108359
 for <qemu-devel@nongnu.org>; Wed, 2 Sep 2026 04:43:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hsVjO+DmhXKJULXtLGCVhQ+MHND5Odh4ZZoRxso5QqU=; b=lhTTBiSnWrWO9Enw
 IVku7o5pYgRq+dvhl6nlQyvILwXuv027xnIy4S6IYHNfSgKsOqqkvKJrCnDx0TSg
 KrCgJLiWG3Xlsx3NgohfAtPZVuGIbeESeuYmiYpAEnm06NfRm3pumcEP7TE3FS+T
 9optHvCUKkx2VWGZAEJWzwBQG4ENf9gW8lA+8q9Ue0mMvv+Z7rEUXp0LHDeZD2w4
 oIKgbiuUvs+cem05XSHNpBOKlzaHmsggDe7kiltOaSs5Cem48AXHedWHT85VJOWM
 PWJSuteEsLNWijOeMXYL3obYzS3dzX+mzr3Q8nX42zbVhzp8aqQWpYhtugp1YzT8
 xvuX6w==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ge1wpan9f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 04:43:17 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38dbf293831so1530552a91.3
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 21:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788324196; x=1788928996; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hsVjO+DmhXKJULXtLGCVhQ+MHND5Odh4ZZoRxso5QqU=;
 b=cIFLjpq9zsIbldNHQiN0JbV/D7UeONBgjiy3qGoI8yulGny0jjvDZxiE4dENEfKoI+
 SGCmIE9Zswn13AFaaZq7y7cWs2AALZG9cE1EEAPdD3YDGXYzPgTQ3qrnCLVcuMZtmkKb
 +RROVOgIczRsLgED6n86g9yhCi4ejzyapezTvWZeIc0ojtcTz7zsEZ6CnQPbSVsA+9Pg
 5hYvVR0BWCjfmfpevtUmR/m6TzOlQCdeumEpaZId+/PrXy3MDHyndiNpcnKk/WXLdeho
 B+XW9U5DG3dcH2XE4E8jZkZYxC0b/cNhhnk2oktkUI9MByw8qAl/DOdy2D5NJmEwYNpi
 T9Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788324196; x=1788928996;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hsVjO+DmhXKJULXtLGCVhQ+MHND5Odh4ZZoRxso5QqU=;
 b=lt3mKDx1ldy4H+brPLH/ar2///dE4jRhPlx2PAQ6ljl3kki76OdC0TKXj/H7Xwez9S
 ceVim6VkL88duFcMil2igQqrYAnQjlrZkEFfLiCIIbJ+MRKcc8nXSf1L8z8SgrEA68Eo
 6Q8j5PSqgJ928J8Ni3V9/t0NPvrqBVUxt9FggUErBKrBVwy3r9qzCNIYRwWE/Bfs/fvY
 aiJ8JUc2JfUoDbbWgi03623KiSWNxEu8HrdJji67alV/eefQeSTSJm3C3hBVupJMOmcR
 ISIlgp5IWbfTruzQJVCE6Fp/5yixh4XN1BSXw7T8zHSB5AnUgzq/4tXa3+AfG74YRBqf
 qTqQ==
X-Gm-Message-State: AFuF++mrIatq+TSB6InrIXnauUg/Q8+gAQbQpaUox70DghRxHGR8YrTx
 YO3ysfoc/DO5d/NsYrBR5aak/gWucEGYasco6ulFK2gV+mWleZ7pjoCVurpBppvAZcRYWEiK4cG
 mQOB7d1Kqi6B72TJMKXbIHj2MAvDJyNZSOPCy7hh1BLGBR9HQlvwBHA16nzYOFiCg+Q==
X-Gm-Gg: AYBFou0+6Zwb9OD08eUrcz71nYRPHe9RMf5dwl7a/YHHp+Pwho6vgA5D0w3xyiFKJtb
 yqAshrIkOoWQE5jxNWi2JDvTBFNSL/itVHgk8f71boP4CgBmPcPRq6Ztth/lQzvpOgLH3jtFcB5
 pPO73a3Lt4Xb+Y+aqo2Q9dEGrYUJFFC8PGeiUVTumHzRwTnfi6M8894TxUH1o0NjsktpxBvWfzk
 6Fv7zj7w/dqE3tV1pKk9IfqiGkbkEU0SaR1xvJv9XyFfbBRkdam3YtVXgLWfABshDFElf6gCIzn
 9dOai1FKqNNiNdlkYQIMbgwqDfNZOPkPXHcY5Mhwyfo2j9S8W5qJgA/RnSG7uqyR25fCJkJkg2q
 BfA9uRY4uisYozzTz2KOQJd/U0OAB72cWIK0FTY89w0eFZSWy
X-Received: by 2002:a17:90b:3d89:b0:398:deed:6e1d with SMTP id
 98e67ed59e1d1-39aedf89bc9mr3282475a91.5.1788324196400; 
 Tue, 01 Sep 2026 21:43:16 -0700 (PDT)
X-Received: by 2002:a17:90b:3d89:b0:398:deed:6e1d with SMTP id
 98e67ed59e1d1-39aedf89bc9mr3281832a91.5.1788324191275; 
 Tue, 01 Sep 2026 21:43:11 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-32f079c33e9sm2933984eec.4.2026.09.01.21.43.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 21:43:10 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 19/28] target/hexagon: gate GPCYCLE guest register reads on
 SSR:CE
Date: Tue,  1 Sep 2026 21:42:22 -0700
Message-Id: <20260902044231.843004-20-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260902044231.843004-1-brian.cain@oss.qualcomm.com>
References: <20260902044231.843004-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=F8JnsKhN c=1 sm=1 tr=0 ts=6a97a965 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=xDRi0JrXNLxaQ6-XZMQA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: Wgjqc_rsJdi6Xb-NJ0WuSq4yUeZ1vH4u
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDA0MCBTYWx0ZWRfX3HMuEuTnwTpU
 T2b5F3VnPB7tqmm3sOIRcHjcq0QdCBs7GZdbEDVFdqqsMvc+gRH6R5ieOjdXv1MTF0tdqBR1qC9
 WZhhX5rfSvLpiOTgwlCqYlzV1rXxK6U=
X-Proofpoint-ORIG-GUID: Wgjqc_rsJdi6Xb-NJ0WuSq4yUeZ1vH4u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDA0MCBTYWx0ZWRfX7/P6kPo0yXpx
 nJA8AoncmYMnAB+FcF/3igzMny7FPW7HkN94kFHajo2h+3PTLwqNgYjOjU8zEsPTSlZJvfLTKWR
 4k3bgRaiaobupgFwsTatw6gIy5pCgYu3ojJUxGFLsZUs7fLKIaB52dSe9XK/Vm/QQeF0EHmYvY+
 OWSxo8OR4llVhl831QYMyAUSDEPxdbvOefHTd1skw2CGDmE7PkxH6N0RrP1Gl2BFuOrCaePjKJ4
 bwOjieAyuTAnns3gLp+J+bQ2QXgyuX42bGljhB3hu3CpcYaRjfV2167KTn79WMwFon4plKLgCzX
 9lLGtKlbstbhqkaeVcnRKTgD/j+0rcFV/pO14BK/Y5/Xb9OJT/2VIMMxzet0/gejE7UtiRG96fr
 ZunyVFXAx3inguVt3LfUIj28AY9IsabLAlDxei3m2jf7z7ZaOUbKIqw+R8hkSihENxMmgl1XWx+
 OspYG9fHYPH03X2bnag==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_06,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 malwarescore=0 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020040
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

R1BDWUNMRUxPL0dQQ1lDTEVISSByZWFkIGFzIHplcm8gdW5sZXNzIHRoZSBjeWNsZSBjb3VudGVy
IGlzIGVuYWJsZWQKKFNTUjpDRSksIG1hdGNoaW5nIHRoZSBoYXJkd2FyZS4KClJldmlld2VkLWJ5
OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQG9zcy5xdWFsY29tbS5jb20+ClNp
Z25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0t
CiB0YXJnZXQvaGV4YWdvbi9jcHUuYyAgICAgICB8IDcgKysrKystLQogdGFyZ2V0L2hleGFnb24v
b3BfaGVscGVyLmMgfCA5ICsrLS0tLS0tLQogMiBmaWxlcyBjaGFuZ2VkLCA3IGluc2VydGlvbnMo
KyksIDkgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vY3B1LmMgYi90
YXJnZXQvaGV4YWdvbi9jcHUuYwppbmRleCA5NmQ4ODgxNDljYy4uZTQxMzhkZjk0NzIgMTAwNjQ0
Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdS5jCisrKyBiL3RhcmdldC9oZXhhZ29uL2NwdS5jCkBA
IC04MDksMTQgKzgwOSwxNyBAQCBzdGF0aWMgdm9pZCBoZXhhZ29uX2NwdV9jbGFzc19pbml0KE9i
amVjdENsYXNzICpjLCBjb25zdCB2b2lkICpkYXRhKQogI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZ
CiB1aW50MzJfdCBoZXhhZ29uX2dyZWdfcmVhZChDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMy
X3QgcmVnKQogeworICAgIHVpbnQzMl90IHNzciA9IGVudi0+dF9zcmVnW0hFWF9TUkVHX1NTUl07
CisgICAgaW50IHNzcl9jZSA9IEdFVF9TU1JfRklFTEQoU1NSX0NFLCBzc3IpOworCiAgICAgaWYg
KHJlZyA8PSBIRVhfR1JFR19HMykgewogICAgICAgICByZXR1cm4gZW52LT5ncmVnW3JlZ107CiAg
ICAgfQogICAgIHN3aXRjaCAocmVnKSB7CiAgICAgY2FzZSBIRVhfR1JFR19HUENZQ0xFTE86Ci0g
ICAgICAgIHJldHVybiBoZXhhZ29uX2dldF9zeXNfcGN5Y2xlX2NvdW50X2xvdyhlbnYpOworICAg
ICAgICByZXR1cm4gc3NyX2NlID8gaGV4YWdvbl9nZXRfc3lzX3BjeWNsZV9jb3VudF9sb3coZW52
KSA6IDA7CiAgICAgY2FzZSBIRVhfR1JFR19HUENZQ0xFSEk6Ci0gICAgICAgIHJldHVybiBoZXhh
Z29uX2dldF9zeXNfcGN5Y2xlX2NvdW50X2hpZ2goZW52KTsKKyAgICAgICAgcmV0dXJuIHNzcl9j
ZSA/IGhleGFnb25fZ2V0X3N5c19wY3ljbGVfY291bnRfaGlnaChlbnYpIDogMDsKICAgICBkZWZh
dWx0OgogICAgICAgICBxZW11X2xvZ19tYXNrKExPR19VTklNUCwgInJlYWRpbmcgZ3JlZyAlIiBQ
UklkMzIKICAgICAgICAgICAgICAgICAiIG5vdCB5ZXQgc3VwcG9ydGVkLlxuIiwgcmVnKTsKZGlm
ZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jIGIvdGFyZ2V0L2hleGFnb24vb3Bf
aGVscGVyLmMKaW5kZXggMjM4OTRmZjNkMjguLjJjZWExOTI3MjYzIDEwMDY0NAotLS0gYS90YXJn
ZXQvaGV4YWdvbi9vcF9oZWxwZXIuYworKysgYi90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYwpA
QCAtMTkxMiwxMyArMTkxMiw4IEBAIHVpbnQ2NF90IEhFTFBFUihncmVnX3JlYWRfcGFpcikoQ1BV
SGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IHJlZykKICAgICAgICAgcmV0dXJuICh1aW50NjRf
dCkoZW52LT5ncmVnW3JlZ10pIHwKICAgICAgICAgICAgICAgICgoKHVpbnQ2NF90KShlbnYtPmdy
ZWdbcmVnICsgMV0pKSA8PCAzMik7CiAgICAgfQotICAgIHN3aXRjaCAocmVnKSB7Ci0gICAgY2Fz
ZSBIRVhfR1JFR19HUENZQ0xFTE86Ci0gICAgICAgIHJldHVybiBoZXhhZ29uX2dldF9zeXNfcGN5
Y2xlX2NvdW50KGVudik7Ci0gICAgZGVmYXVsdDoKLSAgICAgICAgcmV0dXJuICh1aW50NjRfdClo
ZXhhZ29uX2dyZWdfcmVhZChlbnYsIHJlZykgfAotICAgICAgICAgICAgICAgKCh1aW50NjRfdCko
aGV4YWdvbl9ncmVnX3JlYWQoZW52LCByZWcgKyAxKSkgPDwgMzIpOwotICAgIH0KKyAgICByZXR1
cm4gKHVpbnQ2NF90KWhleGFnb25fZ3JlZ19yZWFkKGVudiwgcmVnKSB8CisgICAgICAgICAgICgo
dWludDY0X3QpKGhleGFnb25fZ3JlZ19yZWFkKGVudiwgcmVnICsgMSkpIDw8IDMyKTsKIH0KIAog
LyoKLS0gCjIuMzQuMQoK

