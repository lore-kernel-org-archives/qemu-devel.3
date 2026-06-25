Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1128CDE001
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 14:52:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wclOC-0003c3-75; Thu, 25 Jun 2026 10:49:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wclO6-0002zI-VN
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:49:07 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wclO4-0000DE-6e
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:49:06 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65P9k9TJ1948000
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:48:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=WuFcXxSP9Fzp6C31qhgOnqeUQp9/ystWflMVHLK8WCY=; b=Jz
 dmL9RiJ08HdC6yBPndUy3LFuCddkIJnazr/+esNHg6oXa/P+61QPI95GCnMzXJS9
 eTYKQx1hfUKDg/FNTj6wEyGa7sYHPK8K8tZvjXKVA4wkxoSv26co6oMpVSmroZYR
 Iv5XUx1lZY0rh5Gu5bwSy/84nDTmvAUFzMAKjzfbEk96vghhTGQxD+GqX42Ovq0s
 +rO+7I76WIyDRePNzxTKTzvtT2TuujMeC7Utdxuwb8FezyTXbsLQ7YpeoHJfOiOw
 jk6Ev1jR3AhvaZ2jDRozu48ZB1uNmhL6zNiMXxs5bW3sOybaChpgT4jG0K2RzxPM
 wifPCLcRcOYR13VQTCig==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0ya8su79-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:48:53 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30bcb065bfdso2721629eec.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 07:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782398932; x=1783003732; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WuFcXxSP9Fzp6C31qhgOnqeUQp9/ystWflMVHLK8WCY=;
 b=CR0lAyIYmfN4EPilG83ah2F9vJsADMjFB+zOQ2K+RdYL9OYerTLrDvUO0N87YOBVCK
 yyL/8NDRkKjF/04txzQEMR0vMbffcyPi81pNAH2oOIY1fdFTUUbhrjGPdV1gt1fWMlU7
 FNLxVwG5RZyk56VFCBjTHuR5b/k+usuFHquwRaibl7XQEGagadf5BVdwaNHjMzfXKD0t
 id0IQn9oy4kKg4Zxp+ZsfR9YGJvtumPyYXYJqCVM9QC8MqR6zLyrLW9sP/1pw/2Z3WU+
 2QqMTsk3+7kd3ZWHIXFi8kg+XPrG1GHdVa9cOhbBZj/L1p36Hbd56xRIyAERM7JxFnIt
 0l5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782398932; x=1783003732;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WuFcXxSP9Fzp6C31qhgOnqeUQp9/ystWflMVHLK8WCY=;
 b=fi9gLkWDfQWa6QhOagnYtlNXDsiPwzuXJkHpyjjtOtsNrwoAkmSzZmXJ75vBcCYwVE
 ndOGIPddIxQbOTBrShnV1gEyshpUz/1Gc7JdcReh41CEZZ/9oqV90rYspzLpnXZaLAIG
 5NNEmv1lR8Glrnc0eFu7IEjX3LirV+zlNaHrXll5/gGdfNRM3tZ4MIOktF9xhoMwHD+A
 K21N6Hyz7YlQZpKPIgpnLA9yxOC196jiO+TNAdU2V8ogi8CeNaGVQIjZ2xllCi+wguAg
 ivzF7AJY2mmc6097Wstv4O871H/3WO22TJvXLdrzyR/8w728S5n4oEseAVQU79CVaXbw
 Uonw==
X-Gm-Message-State: AOJu0YzX4xd+1ksqzlDkDOMTabB53ZZt3BKQysJlX3SzxYvocJGqRxx2
 LEhK0ow20o8H8Kmy6uR6oDxanoJCsQPzIgFnjjq2EamsTRfyOJLNN2P5xnbx26yevI3jzpP5D3i
 jyuGtaRa0Bky6CaMifsabTb1XjsuTgnNIa8VzmSDbvLZsfgtlMwrOPO/Pplv8+r3LfQ==
X-Gm-Gg: AfdE7clBbsMWdnJjJjnL6j2ka46mX7QZ15VlqqPwnRyO8RHGyaLoYGulEsGfA8l+/Ty
 YKCKgE83g0rW3IQbQAV8OQgqqPqpJ3+8TO2Wrl8E4PU0haC5Haay73ryYlKD2RVUxkvfavE0P5n
 ragN6l9rEL5LeTDHq5RNAPl56yIjzsDwe6UJK3KAvMMs7aZJWWOOuZ+jHDhl8E5v+/TTfIqKvwV
 zdrLJbWCpe53O2LVJoj6yJh9ft3aF8HDPh8esLNBQHBJrKo1/ciMPcu7/PT9zDCaXYmWxiR9x37
 cHV2AogpvokNGuc8XgtUkwz3USD03zXLDi49orwFo47V7+5HT313pyeJYkH0SKpsuEupewpmMrk
 xGPFBh0tNWHWjS42BDNeEcOR3kkPddh+2cBLLk+j7Gzl2bGliDsXXRDfView=
X-Received: by 2002:a05:693c:6383:10b0:30c:9051:e4be with SMTP id
 5a478bee46e88-30c9051f8ecmr817133eec.35.1782398932127; 
 Thu, 25 Jun 2026 07:48:52 -0700 (PDT)
X-Received: by 2002:a05:693c:6383:10b0:30c:9051:e4be with SMTP id
 5a478bee46e88-30c9051f8ecmr817090eec.35.1782398931375; 
 Thu, 25 Jun 2026 07:48:51 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c8afca8sm8999209eec.17.2026.06.25.07.48.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 07:48:50 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: [PULL v3 69/76] hw/hexagon: Add global register tracing
Date: Thu, 25 Jun 2026 07:16:26 -0700
Message-Id: <20260625141633.449487-70-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
References: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDEyNyBTYWx0ZWRfX8ZR+Sot3yeuW
 pz8Txxbn8ScRevowvV/VaQMIG7V0gu+JBctH3dq6p9BqAH0svqn/eoIHcBsR3Ebpy63y+uEWvsq
 xZ18AkY2ljNVLjcIR++snX9FGK20BSU=
X-Proofpoint-GUID: KzIIMy9r56BPx9Szj7nv-_--Bsnbojp4
X-Proofpoint-ORIG-GUID: KzIIMy9r56BPx9Szj7nv-_--Bsnbojp4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDEyNyBTYWx0ZWRfX5RhJEWz6IFf7
 +B0NiILQ4xwzXD4PHn465yN7UcyG+a9fxBoWXFNRROkkV5E5ySUbzoBn0E5CfDiEMtMOGFPFmYo
 fk9P863Br2oxFoR900dJ9id+ZddJay+cyrgedJBk3sFaAEwE3QUVF0rc1MPw2uFPXwMU0/0XwdF
 E8VU5QNAelKwti4E13oPzDXsHKKRrh8KknrhYkSYJEXL2c6B7PIzLTd0FH6Asw73DdNUmcTGzG7
 dZrWyPRdcWH4sSlOkPnzDoEO6p+wFOWLAE0UynBAftEl00wW/YkwDq7q4rqbzeY0FsiD8Pk1VIa
 l3PSBFMtlGpmi2AEpc6PPgUGKJkhT895g6aYiD97O/YPgQnZT9O/cgNUR6j5cJMpIKBTXQzTqH8
 47E3P4yilT8zU4/yNdH1EGPRse38/dkQWnA8Zy8YH/wDgQ7+G4RYQDevgzK6aKKQ2XPbfXS9n19
 loSE1n2SEpwcPvUFeuw==
X-Authority-Analysis: v=2.4 cv=Z+Xc2nRA c=1 sm=1 tr=0 ts=6a3d3fd5 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=8QmChvNvioVktlEtA_0A:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0
 spamscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606250127
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

UmV2aWV3ZWQtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4K
U2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgot
LS0KIG1lc29uLmJ1aWxkICAgICAgICAgICAgICAgICAgICB8ICAxICsKIGh3L2hleGFnb24vdHJh
Y2UuaCAgICAgICAgICAgICB8ICAyICsKIGh3L2hleGFnb24vaGV4YWdvbl9nbG9iYWxyZWcuYyB8
IDczICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIGh3L2hleGFnb24vdHJhY2Ut
ZXZlbnRzICAgICAgICB8ICAzICsrCiA0IGZpbGVzIGNoYW5nZWQsIDc5IGluc2VydGlvbnMoKykK
IGNyZWF0ZSBtb2RlIDEwMDY0NCBody9oZXhhZ29uL3RyYWNlLmgKIGNyZWF0ZSBtb2RlIDEwMDY0
NCBody9oZXhhZ29uL3RyYWNlLWV2ZW50cwoKZGlmZiAtLWdpdCBhL21lc29uLmJ1aWxkIGIvbWVz
b24uYnVpbGQKaW5kZXggZTAyNjg1MTMwOWUuLmQ0MjA2YTVkM2Y4IDEwMDY0NAotLS0gYS9tZXNv
bi5idWlsZAorKysgYi9tZXNvbi5idWlsZApAQCAtMzU5OSw2ICszNTk5LDcgQEAgaWYgaGF2ZV9z
eXN0ZW0KICAgICAnaHcvZGlzcGxheScsCiAgICAgJ2h3L2RtYScsCiAgICAgJ2h3L2ZzaScsCisg
ICAgJ2h3L2hleGFnb24nLAogICAgICdody9oeXBlcnYnLAogICAgICdody9pMmMnLAogICAgICdo
dy9pM2MnLApkaWZmIC0tZ2l0IGEvaHcvaGV4YWdvbi90cmFjZS5oIGIvaHcvaGV4YWdvbi90cmFj
ZS5oCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAwMDAwLi45ZTBiMzlmM2M2Ngot
LS0gL2Rldi9udWxsCisrKyBiL2h3L2hleGFnb24vdHJhY2UuaApAQCAtMCwwICsxLDIgQEAKKy8q
IFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyICovCisjaW5jbHVkZSAi
dHJhY2UvdHJhY2UtaHdfaGV4YWdvbi5oIgpkaWZmIC0tZ2l0IGEvaHcvaGV4YWdvbi9oZXhhZ29u
X2dsb2JhbHJlZy5jIGIvaHcvaGV4YWdvbi9oZXhhZ29uX2dsb2JhbHJlZy5jCmluZGV4IDI4Y2I1
YTQxNThkLi5iNWU1OTEzNTA3ZSAxMDA2NDQKLS0tIGEvaHcvaGV4YWdvbi9oZXhhZ29uX2dsb2Jh
bHJlZy5jCisrKyBiL2h3L2hleGFnb24vaGV4YWdvbl9nbG9iYWxyZWcuYwpAQCAtMTYsMTEgKzE2
LDgyIEBACiAjaW5jbHVkZSAidGFyZ2V0L2hleGFnb24vY3B1LmgiCiAjaW5jbHVkZSAidGFyZ2V0
L2hleGFnb24vaGV4X3JlZ3MuaCIKICNpbmNsdWRlICJxZW11L2xvZy5oIgorI2luY2x1ZGUgInRy
YWNlLmgiCiAjaW5jbHVkZSAicWFwaS9lcnJvci5oIgogCiAjZGVmaW5lIElNTVVUQUJMRSAofjAp
CiAjZGVmaW5lIElOVkFMSURfUkVHX1ZBTCAweGRlYWRiZWVmCiAKK3N0YXRpYyBjb25zdCBjaGFy
ICpoZXhfc3JlZ19uYW1lc1tdID0geworICAgIFtIRVhfU1JFR19TR1AwXSA9ICJzZ3AwIiwKKyAg
ICBbSEVYX1NSRUdfU0dQMV0gPSAic2dwMSIsCisgICAgW0hFWF9TUkVHX1NUSURdID0gInN0aWQi
LAorICAgIFtIRVhfU1JFR19FTFJdID0gImVsciIsCisgICAgW0hFWF9TUkVHX0JBRFZBMF0gPSAi
YmFkdmEwIiwKKyAgICBbSEVYX1NSRUdfQkFEVkExXSA9ICJiYWR2YTEiLAorICAgIFtIRVhfU1JF
R19TU1JdID0gInNzciIsCisgICAgW0hFWF9TUkVHX0NDUl0gPSAiY2NyIiwKKyAgICBbSEVYX1NS
RUdfSFRJRF0gPSAiaHRpZCIsCisgICAgW0hFWF9TUkVHX0JBRFZBXSA9ICJiYWR2YSIsCisgICAg
W0hFWF9TUkVHX0lNQVNLXSA9ICJpbWFzayIsCisgICAgW0hFWF9TUkVHX0dFVkJdID0gImdldmIi
LAorICAgIFtIRVhfU1JFR19FVkJdID0gImV2YiIsCisgICAgW0hFWF9TUkVHX01PREVDVExdID0g
Im1vZGVjdGwiLAorICAgIFtIRVhfU1JFR19TWVNDRkddID0gInN5c2NmZyIsCisgICAgW0hFWF9T
UkVHX0lQRU5EQURdID0gImlwZW5kYWQiLAorICAgIFtIRVhfU1JFR19WSURdID0gInZpZCIsCisg
ICAgW0hFWF9TUkVHX1ZJRDFdID0gInZpZDEiLAorICAgIFtIRVhfU1JFR19CRVNUV0FJVF0gPSAi
YmVzdHdhaXQiLAorICAgIFtIRVhfU1JFR19JRUxdID0gImllbCIsCisgICAgW0hFWF9TUkVHX1ND
SEVEQ0ZHXSA9ICJzY2hlZGNmZyIsCisgICAgW0hFWF9TUkVHX0lBSExdID0gImlhaGwiLAorICAg
IFtIRVhfU1JFR19DRkdCQVNFXSA9ICJjZmdiYXNlIiwKKyAgICBbSEVYX1NSRUdfRElBR10gPSAi
ZGlhZyIsCisgICAgW0hFWF9TUkVHX1JFVl0gPSAicmV2IiwKKyAgICBbSEVYX1NSRUdfUENZQ0xF
TE9dID0gInBjeWNsZWxvIiwKKyAgICBbSEVYX1NSRUdfUENZQ0xFSEldID0gInBjeWNsZWhpIiwK
KyAgICBbSEVYX1NSRUdfSVNEQlNUXSA9ICJpc2Ric3QiLAorICAgIFtIRVhfU1JFR19JU0RCQ0ZH
MF0gPSAiaXNkYmNmZzAiLAorICAgIFtIRVhfU1JFR19JU0RCQ0ZHMV0gPSAiaXNkYmNmZzEiLAor
ICAgIFtIRVhfU1JFR19MSVZFTE9DS10gPSAibGl2ZWxvY2siLAorICAgIFtIRVhfU1JFR19CUktQ
VFBDMF0gPSAiYnJrcHRwYzAiLAorICAgIFtIRVhfU1JFR19CUktQVENGRzBdID0gImJya3B0Y2Zn
MCIsCisgICAgW0hFWF9TUkVHX0JSS1BUUEMxXSA9ICJicmtwdHBjMSIsCisgICAgW0hFWF9TUkVH
X0JSS1BUQ0ZHMV0gPSAiYnJrcHRjZmcxIiwKKyAgICBbSEVYX1NSRUdfSVNEQk1CWElOXSA9ICJp
c2RibWJ4aW4iLAorICAgIFtIRVhfU1JFR19JU0RCTUJYT1VUXSA9ICJpc2RibWJ4b3V0IiwKKyAg
ICBbSEVYX1NSRUdfSVNEQkVOXSA9ICJpc2RiZW4iLAorICAgIFtIRVhfU1JFR19JU0RCR1BSXSA9
ICJpc2RiZ3ByIiwKKyAgICBbSEVYX1NSRUdfUE1VQ05UNF0gPSAicG11Y250NCIsCisgICAgW0hF
WF9TUkVHX1BNVUNOVDVdID0gInBtdWNudDUiLAorICAgIFtIRVhfU1JFR19QTVVDTlQ2XSA9ICJw
bXVjbnQ2IiwKKyAgICBbSEVYX1NSRUdfUE1VQ05UN10gPSAicG11Y250NyIsCisgICAgW0hFWF9T
UkVHX1BNVUNOVDBdID0gInBtdWNudDAiLAorICAgIFtIRVhfU1JFR19QTVVDTlQxXSA9ICJwbXVj
bnQxIiwKKyAgICBbSEVYX1NSRUdfUE1VQ05UMl0gPSAicG11Y250MiIsCisgICAgW0hFWF9TUkVH
X1BNVUNOVDNdID0gInBtdWNudDMiLAorICAgIFtIRVhfU1JFR19QTVVFVlRDRkddID0gInBtdWV2
dGNmZyIsCisgICAgW0hFWF9TUkVHX1BNVVNUSUQwXSA9ICJwbXVzdGlkMCIsCisgICAgW0hFWF9T
UkVHX1BNVUVWVENGRzFdID0gInBtdWV2dGNmZzEiLAorICAgIFtIRVhfU1JFR19QTVVTVElEMV0g
PSAicG11c3RpZDEiLAorICAgIFtIRVhfU1JFR19USU1FUkxPXSA9ICJ0aW1lcmxvIiwKKyAgICBb
SEVYX1NSRUdfVElNRVJISV0gPSAidGltZXJoaSIsCisgICAgW0hFWF9TUkVHX1BNVUNGR10gPSAi
cG11Y2ZnIiwKKyAgICBbSEVYX1NSRUdfUzU5XSA9ICJzNTkiLAorICAgIFtIRVhfU1JFR19TNjBd
ID0gInM2MCIsCisgICAgW0hFWF9TUkVHX1M2MV0gPSAiczYxIiwKKyAgICBbSEVYX1NSRUdfUzYy
XSA9ICJzNjIiLAorICAgIFtIRVhfU1JFR19TNjNdID0gInM2MyIsCit9OworCitzdGF0aWMgY29u
c3QgY2hhciAqZ2V0X3NyZWdfbmFtZSh1aW50MzJfdCByZWcpCit7CisgICAgaWYgKHJlZyA8IEFS
UkFZX1NJWkUoaGV4X3NyZWdfbmFtZXMpICYmIGhleF9zcmVnX25hbWVzW3JlZ10pIHsKKyAgICAg
ICAgcmV0dXJuIGhleF9zcmVnX25hbWVzW3JlZ107CisgICAgfQorICAgIHJldHVybiAiVU5LTk9X
TiI7Cit9CisKIC8qIEdsb2JhbCBzeXN0ZW0gcmVnaXN0ZXIgbXV0YWJpbGl0eSBtYXNrcyAqLwog
c3RhdGljIGNvbnN0IHVpbnQzMl90IGdsb2JhbF9zcmVnX2ltbXV0X21hc2tzW05VTV9TUkVHU10g
PSB7CiAgICAgW0hFWF9TUkVHX0VWQl0gPSAweDAwMDAwMGZmLApAQCAtNzcsNiArMTQ4LDcgQEAg
dWludDMyX3QgaGV4YWdvbl9nbG9iYWxyZWdfcmVhZChIZXhhZ29uR2xvYmFsUmVnU3RhdGUgKnMs
IHVpbnQzMl90IHJlZywKIAogICAgIHZhbHVlID0gcy0+cmVnc1tyZWddOwogCisgICAgdHJhY2Vf
aGV4YWdvbl9nbG9iYWxyZWdfcmVhZChodGlkLCBnZXRfc3JlZ19uYW1lKHJlZyksIHZhbHVlKTsK
ICAgICByZXR1cm4gdmFsdWU7CiB9CiAKQEAgLTg5LDYgKzE2MSw3IEBAIHZvaWQgaGV4YWdvbl9n
bG9iYWxyZWdfd3JpdGUoSGV4YWdvbkdsb2JhbFJlZ1N0YXRlICpzLCB1aW50MzJfdCByZWcsCiAg
ICAgZ19hc3NlcnQocmVnIDwgTlVNX1NSRUdTKTsKICAgICBnX2Fzc2VydChyZWcgPj0gSEVYX1NS
RUdfR0xCX1NUQVJUKTsKICAgICBzLT5yZWdzW3JlZ10gPSB2YWx1ZTsKKyAgICB0cmFjZV9oZXhh
Z29uX2dsb2JhbHJlZ193cml0ZShodGlkLCBnZXRfc3JlZ19uYW1lKHJlZyksIHZhbHVlKTsKIH0K
IAogdWludDMyX3QgaGV4YWdvbl9nbG9iYWxyZWdfbWFza2VkX3ZhbHVlKEhleGFnb25HbG9iYWxS
ZWdTdGF0ZSAqcywgdWludDMyX3QgcmVnLApkaWZmIC0tZ2l0IGEvaHcvaGV4YWdvbi90cmFjZS1l
dmVudHMgYi9ody9oZXhhZ29uL3RyYWNlLWV2ZW50cwpuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRl
eCAwMDAwMDAwMDAwMC4uNWQ2MjNlZDI1MTYKLS0tIC9kZXYvbnVsbAorKysgYi9ody9oZXhhZ29u
L3RyYWNlLWV2ZW50cwpAQCAtMCwwICsxLDMgQEAKKyMgSGV4YWdvbiBnbG9iYWwgcmVnaXN0ZXIg
YWNjZXNzCitoZXhhZ29uX2dsb2JhbHJlZ19yZWFkKHVpbnQzMl90IGh0aWQsIGNvbnN0IGNoYXIg
KnJlZ19uYW1lLCB1aW50MzJfdCB2YWx1ZSkgImh0aWQ9JXUgcmVnPSVzIHZhbHVlPTB4JXgiCito
ZXhhZ29uX2dsb2JhbHJlZ193cml0ZSh1aW50MzJfdCBodGlkLCBjb25zdCBjaGFyICpyZWdfbmFt
ZSwgdWludDMyX3QgdmFsdWUpICJodGlkPSV1IHJlZz0lcyB2YWx1ZT0weCV4IgotLSAKMi4zNC4x
Cgo=

