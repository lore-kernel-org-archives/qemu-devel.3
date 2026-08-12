Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0B63C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:43:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuB6s-0004UH-R7; Wed, 12 Aug 2026 11:43:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wuB6Y-0004LC-MH
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 11:42:59 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wuB6V-0000FY-6Z
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 11:42:58 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CDcsTb3654846
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 15:42:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=2TDWanm7s5saDWID0dlBmKuXPvzhlMSOUqamjpo0QYE=; b=bs
 DckON7bSfbO85/gOsmdgeOEZHnJoDs+hoKMeAvq545kRtdazr6SH9ChEWTE3Ungn
 QN9Fgk4Vhd5CMaame063EvXrFWETBGr5hQEi4BoTasstrL3s/XURvulbYdc0mZSh
 T+C0O1s9TDyvZpdVhfdumEjWorPN2SNbCifY29eHWD7L4VgX3kgQ55IXHvbMWTii
 jIg8FVZcDRBDHUZ3hbCSJYmgevMqT4ggcRnLYUZERkOJAqaoIS/L248xazgqXAw/
 ONdQt0bEPudDazFZUP2o9qri5BBLfy393v6JDQFtVAadnHL2ep9uNDxsLb+vOS4K
 TPIiJZRgoYFz562o0hMA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0pmysfb9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 15:42:52 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cbee8d434b8so13931a12.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 08:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786549372; x=1787154172; darn=nongnu.org;
 h=content-transfer-encoding:content-type:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=2TDWanm7s5saDWID0dlBmKuXPvzhlMSOUqamjpo0QYE=;
 b=H+XLO9LHUYvwR8XSg+lg1b51idN3Olt+thV9JQOP3Fi7+C1n/3vfxtSOUbA+pGYR/h
 h5MR++fB41ZhpXKgcoFhqsxWN/vFDOXGGZm+udRlbRiL05XqWug6nUhltNTPNEYoiZ6M
 9QoEXZ3wj8Fch6m8uC+7y2mZjlvTPC+i3FrupEhM4U58O1xcAe+WC+MHQw7WaNbMO9oV
 hYNSxfGR4KF82G6HSyXrwFWoU9YUnfQDrZC0VHYMqFUq2C54jOKaSYinDAsaENV4vgFZ
 sGf9Nct3mhrwyGYRF8mvrmjVlXAkV4jAVneBpzJDYZ5Idv77YEwy2xPHi07wNczfObcI
 GWkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786549372; x=1787154172;
 h=content-transfer-encoding:content-type:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2TDWanm7s5saDWID0dlBmKuXPvzhlMSOUqamjpo0QYE=;
 b=d7Xbq0D3QgBcJIVEOqsaAy9xefQveb7vjmsyID+IZoCwvyxmEli0FGukqGTY77heTh
 +u++g93vtRevx1qnVlP6xTgXytqze9pd7Et1zCAmfXVejW7UlD6OFJPJbP4StPCLWjR9
 P9XehKu/eocLEbH9z7Utpf5sts6wl08roxWE9TN2ps+jAw8+uoQYzZ0ct8+1zVKhA0bM
 IvsBT+xVKzFqbg7SgFujNpQK2C0Co9xFM6Q41db66YwJC5BOXAwovCZNUHBK1zRb4Y7t
 2kRiNcQ7z0xvc3OhED4V5aAMjMxhWo6PQuXm4lySUBVAOYpEiK8Wn1YRKuLcektZdOyz
 lvsg==
X-Gm-Message-State: AOJu0YzTdcelVETQqat6HURjR0bB0Z/VIjvGD/tNXZJA8Ka99s5Z9dyM
 /NiDimiDeRkPt0/mhRnsEeqbZ9R6yQfA1Ra4Ukc8BEHriFHkoQA5YIDLtNZvBnacy6CxweDvjZm
 9IDUaMB9IgSeq9YvfeZWb/uJeiQ2arKhK78kZpsMxJ9e2K44wQke8osbecIBSUztO2Q==
X-Gm-Gg: AR+sD130q+wL2D6y9Sg7RZCnQz7g8RR0LPuhHLT/PXZM1k7D33+pECzRuwVSVAOFGc4
 5tPitXLr3BvuI/IaINQtsWZoKWWypuiP2dUvkZ/TPT5wWAk/V53JYE5pwoh2TaTgYTx8JdVpr2Z
 pxxnpK0fefZd5jwtI/+eS/hMlnNbcN3BoNU9/aJiiGf6AyThGuj2dvtvlyzW4T3Wm7S2AVIoMLi
 tkfo0SU0tJ1goSzaMXz5QGWOdNNfEyGSO0tztUDd70JinkAvKAYaYBZ1AxP5V+mhEhD0CT63yKi
 bZR/o56yqESiK0GQUlluJJP14JUqbJhpLb9A0+a+GcyoOM08+TAeMW1ftFumTbzBdDIUg9jela7
 8glJWxGt8oS0LOGaVYMdvkBaa6nQr2Evvu2QYxMh3Xhl6Ual/
X-Received: by 2002:a05:6a21:3987:b0:3cb:b6b0:1b83 with SMTP id
 adf61e73a8af0-3cc53129aeemr115554637.9.1786549371472; 
 Wed, 12 Aug 2026 08:42:51 -0700 (PDT)
X-Received: by 2002:a05:6a21:3987:b0:3cb:b6b0:1b83 with SMTP id
 adf61e73a8af0-3cc53129aeemr115443637.9.1786549370899; 
 Wed, 12 Aug 2026 08:42:50 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31da7bf64b5sm8121190eec.10.2026.08.12.08.42.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 08:42:49 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v2 08/41] hw/hexagon: extract get_reg_value/set_reg_value stubs
 in globalreg
Date: Wed, 12 Aug 2026 08:41:47 -0700
Message-Id: <20260812154220.1029828-9-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260812154220.1029828-1-brian.cain@oss.qualcomm.com>
References: <20260812154220.1029828-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEyOCBTYWx0ZWRfXzBX6SLP1FqXy
 0V0EwGEXYoRResNcr9cYT/v61gYKL7Akk4lUcVrBPhwc1m4FgCP1WyF3s/8VigbzLiO//L7PouT
 pjupxPHtyeZ0m+KDbpGCR2ynHhr0rnM=
X-Proofpoint-ORIG-GUID: ZyBYnoTIQE5QnjErMFEeTnhcy8RLw1lt
X-Authority-Analysis: v=2.4 cv=C/fZDwP+ c=1 sm=1 tr=0 ts=6a7c947c cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=9smrWREWR_s8Awy1JTMA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: ZyBYnoTIQE5QnjErMFEeTnhcy8RLw1lt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEyOCBTYWx0ZWRfX/mUWZoAmCuN7
 Vc6WHWF+Xm+jbclwwmeHt10YoS6WFRx2td3KtKcy0KGqnthZu9SgMxCOYJUNfJhXNeVJeJE8qIL
 hwrK5KOHAP7vvjltQw38pq/EV5vZvzcGdRraNGmQ5WH/Ii3lzsHgn/XpjwsJcQS8180/OYnnkM7
 6qEydJp+s2TnOoiMoNIOwKLANIOx2aCtzagMR+iND/4oFmR73z6B6YQrY95vU99bC5qr3Rkh8T/
 fAlhu5CqWL+LC6HIOi/rPcOotnqf457FwWDc/2Zn7IqsxAZx1mm8Lug1WyAmpO3CNtLTbPx5LCm
 BZNJkFo6C3seU9i09WBBF7NsTtf/jwpLsvuwCl5YXWgV5ueyH9mMTqoLx56Vs8glqlD3sg5xEIg
 lcrc8xOcqIQ+W8ScMostJkMOxoVWwQ45wz3qohNzTTKG9hgCwJdFmpVFOaq4/9teMVLvbgU72fZ
 tpv/KC8WeLmQY2n7AFg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0 malwarescore=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120128
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

Um91dGUgdGhlIGdsb2JhbHJlZyByZWFkL3dyaXRlIGFjY2Vzc29ycyB0aHJvdWdoIG5ldwpnZXRf
cmVnX3ZhbHVlKCkvc2V0X3JlZ192YWx1ZSgpIGhlbHBlcnMgaW5zdGVhZCBvZiB0b3VjaGluZwpz
LT5yZWdzW3JlZ10gZGlyZWN0bHkuCgpUaGlzIHdpbGwgYmUgZXhwbG9pdGVkIGJ5IGEgc3Vic2Vx
dWVudCBwYXRjaCB0aGF0IHJlZGlyZWN0cyBWSUQvVklEMQphY2Nlc3NlcyB0byB0aGUgTDJWSUMu
CgpSZXZpZXdlZC1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBvc3MucXVhbGNv
bW0uY29tPgpMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsLzIwMjYwODA2
MDQyNzIzLjM3ODUzNjktOS1icmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20KU2lnbmVkLW9mZi1i
eTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIGh3L2hleGFn
b24vaGV4YWdvbl9nbG9iYWxyZWcuYyB8IDIzICsrKysrKysrKysrKysrKysrKy0tLS0tCiAxIGZp
bGUgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQg
YS9ody9oZXhhZ29uL2hleGFnb25fZ2xvYmFscmVnLmMgYi9ody9oZXhhZ29uL2hleGFnb25fZ2xv
YmFscmVnLmMKaW5kZXggYjVlNTkxMzUwN2UuLjEwNTQ3NTIxOWFiIDEwMDY0NAotLS0gYS9ody9o
ZXhhZ29uL2hleGFnb25fZ2xvYmFscmVnLmMKKysrIGIvaHcvaGV4YWdvbi9oZXhhZ29uX2dsb2Jh
bHJlZy5jCkBAIC0xMzUsNiArMTM1LDE3IEBAIHN0YXRpYyBpbmxpbmUgdWludDMyX3QgYXBwbHlf
d3JpdGVfbWFzayh1aW50MzJfdCBuZXdfdmFsLCB1aW50MzJfdCBjdXJfdmFsLAogICAgIHJldHVy
biBuZXdfdmFsOwogfQogCitzdGF0aWMgdWludDMyX3QgZ2V0X3JlZ192YWx1ZShIZXhhZ29uR2xv
YmFsUmVnU3RhdGUgKnMsIHVpbnQzMl90IHJlZykKK3sKKyAgICByZXR1cm4gcy0+cmVnc1tyZWdd
OworfQorCitzdGF0aWMgdm9pZCBzZXRfcmVnX3ZhbHVlKEhleGFnb25HbG9iYWxSZWdTdGF0ZSAq
cywgdWludDMyX3QgcmVnLAorICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50MzJfdCB2YWx1
ZSkKK3sKKyAgICBzLT5yZWdzW3JlZ10gPSB2YWx1ZTsKK30KKwogdWludDMyX3QgaGV4YWdvbl9n
bG9iYWxyZWdfcmVhZChIZXhhZ29uR2xvYmFsUmVnU3RhdGUgKnMsIHVpbnQzMl90IHJlZywKICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDMyX3QgaHRpZCkKIHsKQEAgLTE0Niw3
ICsxNTcsNyBAQCB1aW50MzJfdCBoZXhhZ29uX2dsb2JhbHJlZ19yZWFkKEhleGFnb25HbG9iYWxS
ZWdTdGF0ZSAqcywgdWludDMyX3QgcmVnLAogICAgIGdfYXNzZXJ0KHJlZyA8IE5VTV9TUkVHUyk7
CiAgICAgZ19hc3NlcnQocmVnID49IEhFWF9TUkVHX0dMQl9TVEFSVCk7CiAKLSAgICB2YWx1ZSA9
IHMtPnJlZ3NbcmVnXTsKKyAgICB2YWx1ZSA9IGdldF9yZWdfdmFsdWUocywgcmVnKTsKIAogICAg
IHRyYWNlX2hleGFnb25fZ2xvYmFscmVnX3JlYWQoaHRpZCwgZ2V0X3NyZWdfbmFtZShyZWcpLCB2
YWx1ZSk7CiAgICAgcmV0dXJuIHZhbHVlOwpAQCAtMTYwLDcgKzE3MSw3IEBAIHZvaWQgaGV4YWdv
bl9nbG9iYWxyZWdfd3JpdGUoSGV4YWdvbkdsb2JhbFJlZ1N0YXRlICpzLCB1aW50MzJfdCByZWcs
CiAgICAgfQogICAgIGdfYXNzZXJ0KHJlZyA8IE5VTV9TUkVHUyk7CiAgICAgZ19hc3NlcnQocmVn
ID49IEhFWF9TUkVHX0dMQl9TVEFSVCk7Ci0gICAgcy0+cmVnc1tyZWddID0gdmFsdWU7CisgICAg
c2V0X3JlZ192YWx1ZShzLCByZWcsIHZhbHVlKTsKICAgICB0cmFjZV9oZXhhZ29uX2dsb2JhbHJl
Z193cml0ZShodGlkLCBnZXRfc3JlZ19uYW1lKHJlZyksIHZhbHVlKTsKIH0KIApAQCAtMTY4LDYg
KzE3OSw3IEBAIHVpbnQzMl90IGhleGFnb25fZ2xvYmFscmVnX21hc2tlZF92YWx1ZShIZXhhZ29u
R2xvYmFsUmVnU3RhdGUgKnMsIHVpbnQzMl90IHJlZywKICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICB1aW50MzJfdCB2YWx1ZSkKIHsKICAgICB1aW50MzJfdCByZWdfbWFz
azsKKyAgICB1aW50MzJfdCBjdXJfdmFsOwogCiAgICAgaWYgKCFzKSB7CiAgICAgICAgIHJldHVy
biB2YWx1ZTsKQEAgLTE3NSw5ICsxODcsMTAgQEAgdWludDMyX3QgaGV4YWdvbl9nbG9iYWxyZWdf
bWFza2VkX3ZhbHVlKEhleGFnb25HbG9iYWxSZWdTdGF0ZSAqcywgdWludDMyX3QgcmVnLAogICAg
IGdfYXNzZXJ0KHJlZyA8IE5VTV9TUkVHUyk7CiAgICAgZ19hc3NlcnQocmVnID49IEhFWF9TUkVH
X0dMQl9TVEFSVCk7CiAgICAgcmVnX21hc2sgPSBnbG9iYWxfc3JlZ19pbW11dF9tYXNrc1tyZWdd
OworICAgIGN1cl92YWwgPSBnZXRfcmVnX3ZhbHVlKHMsIHJlZyk7CiAgICAgcmV0dXJuIHJlZ19t
YXNrID09IElNTVVUQUJMRSA/Ci0gICAgICAgICAgICBzLT5yZWdzW3JlZ10gOgotICAgICAgICAg
ICAgYXBwbHlfd3JpdGVfbWFzayh2YWx1ZSwgcy0+cmVnc1tyZWddLCByZWdfbWFzayk7CisgICAg
ICAgICAgICBjdXJfdmFsIDoKKyAgICAgICAgICAgIGFwcGx5X3dyaXRlX21hc2sodmFsdWUsIGN1
cl92YWwsIHJlZ19tYXNrKTsKIH0KIAogdm9pZCBoZXhhZ29uX2dsb2JhbHJlZ193cml0ZV9tYXNr
ZWQoSGV4YWdvbkdsb2JhbFJlZ1N0YXRlICpzLCB1aW50MzJfdCByZWcsCkBAIC0xODYsNyArMTk5
LDcgQEAgdm9pZCBoZXhhZ29uX2dsb2JhbHJlZ193cml0ZV9tYXNrZWQoSGV4YWdvbkdsb2JhbFJl
Z1N0YXRlICpzLCB1aW50MzJfdCByZWcsCiAgICAgaWYgKCFzKSB7CiAgICAgICAgIHJldHVybjsK
ICAgICB9Ci0gICAgcy0+cmVnc1tyZWddID0gaGV4YWdvbl9nbG9iYWxyZWdfbWFza2VkX3ZhbHVl
KHMsIHJlZywgdmFsdWUpOworICAgIHNldF9yZWdfdmFsdWUocywgcmVnLCBoZXhhZ29uX2dsb2Jh
bHJlZ19tYXNrZWRfdmFsdWUocywgcmVnLCB2YWx1ZSkpOwogfQogCiB1aW50NjRfdCBoZXhhZ29u
X2dsb2JhbHJlZ19nZXRfcGN5Y2xlX2Jhc2UoSGV4YWdvbkdsb2JhbFJlZ1N0YXRlICpzKQotLSAK
Mi4zNC4xCgo=

