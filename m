Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A17DC531C9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 18:38:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnKm4-0002LP-Md; Fri, 24 Jul 2026 14:37:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wnKln-0002Fc-8p
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 14:37:20 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wnKlj-0000zi-Dn
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 14:37:13 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66OHBNtu3683270
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 18:37:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GhQnLWWiUGO5P3NDVBX5O4g6byktQ5bXhd4epAk9mqk=; b=cBx0vcUL16vQum7h
 hxkPV/JM/CUJVhhRAvBTZy+LutSQmxGPIYi8k86Y5/SIYaIoFY8ERIwv3DnZfmte
 R8uUOSyePbJEVSsof7Rhk58ZHC6uv8zFZYqfU5Zy69rqxqZPJ1Q7iT368WlNrrSa
 osK0aAzKJFmWRUUMkRXzT7tjDqDBEIGyRDEyD+N2EYv0cCgkPMVIm0iXrOj4lmKe
 KcdcXjdUW6XKo1dKznAwx/EuyztTW7YWz5PL9ksJDk9a9kKMF2DpE96nE8pJY+qM
 7D5wdwPimT7HK6K0b+4MPWvubRnwAthnfudTXoIPmi5m0HnPqBw4/htQ7j1qPYD6
 xxrIvQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fmc7x09pw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 18:37:10 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38f0fe57470so761905a91.0
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 11:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784918229; x=1785523029; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GhQnLWWiUGO5P3NDVBX5O4g6byktQ5bXhd4epAk9mqk=;
 b=FmdXH4PRBkWwf41L5NBQv5jhgVC2l8aou35baCUUTN9nup/e+YvvzO6a0KG9kz89U9
 ODAy9K8Nd6y4frcVb/DXCoVNYixPsRnayatpYgKqMPAnEYRUjNw9XBO6NaNWtx7KdrEU
 UWc7wJj9HOkMtDJbRVi0ax/xi4DSJsJ+RYMWf/GKdq1jWoQ3F1yMWv2HdUPf9X4XO0W2
 +1ttpURbR9SyCd/oW/iLrrojAQ8BbrJWz37Z/gPCNECdXtCsJOaxX2h/At6/iHZNyKQ5
 xu8neHdsF4CDaxD4Fc+d6ZXYdbzEnfteYGDW/4yToq+ciqEv1Gx/N2sFQkhJ4mj0BDpp
 A3iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784918229; x=1785523029;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GhQnLWWiUGO5P3NDVBX5O4g6byktQ5bXhd4epAk9mqk=;
 b=eoGoZapc2m0Dy3HoUmS18E+BFScRGz49rDd5ZgJWsIz3XslKNVrZIAWk9EnaEVLq43
 uuQ/5UIk1pyKRxeIdcbB8KJimLYM966tBhmmv4HgXcO3tNFiHQlV8lGfqGuLHKnOcGoj
 aVXkMa3Vv0UBXXQN/ZqLbH+isbjGoCH+En0spnQJ1r/st1gSPvTC2l8VECdxPjyUbqW8
 eIeF6/NsKRPMMbJGiQLgg3zzBFibNdJgwpJsslufqHrEU45UXuyczubEh6I0t10GRrAI
 LqLZAlEtgJCVHgC2RcF05mpuCma9yHBX2xurPOqHX4OS6x8XHrrcOQzsh5Zw60Syl4wC
 J+NQ==
X-Gm-Message-State: AOJu0YxRf0oy56FOahdwdnd+3DHkDiPa+9Pa+0gRI/MD/sK3QejXey2p
 jAejjh1sM6PnPBcQvKdQML8CzdXFCvlAchBVgK3Tia/p6j/9ns/FDx1m1P7yPzbttYSexIaQFoe
 XVojKxbZJQjzzmVLtc306CgcMC5qA1F4kdnse6YASESRDgjHYttvzF1gjyBwJRu7CKg==
X-Gm-Gg: AR+sD11sQU7hei2H3v5TRuFPlq0GBQTswA4pwrwYi2/AoARzJevj1nOE6WH6LHEVx5J
 8ldOI3vstiGmRQSbq4D32oKO99q46+Cy22KneI19m7nWro/AY/b86EXcUcwuvW2bvsqV/GXemfb
 OA8OVS5dt+mvrJVXqs3m89Cnv2c05NfmD6mATKYB0qhQ4OlLjxzQL4HlCpqqubn8XxeZGWCZEqE
 ipnIONJa4vmbwpClJ2O2E81hIzK8tXoMN02CUrsK0lK0vBDHg+5A+zXVMrw7sc7PPoG54T9Xvg5
 ofwcUto+JA9Vh3cuwHpS25RrjNnBXkJ5Rqt9Jrccq2y8I+VjPQ/6hiEFTpoQ7LxvRmpGDmDlRld
 FCXFeMlTFS2VAPjPd5dC9Cx1xc8JitQFroNgeOsYh7Cq3XWC0
X-Received: by 2002:a17:90b:2705:b0:38e:a52e:a3c9 with SMTP id
 98e67ed59e1d1-38f1ebf111fmr1553766a91.8.1784918229568; 
 Fri, 24 Jul 2026 11:37:09 -0700 (PDT)
X-Received: by 2002:a17:90b:2705:b0:38e:a52e:a3c9 with SMTP id
 98e67ed59e1d1-38f1ebf111fmr1553741a91.8.1784918229157; 
 Fri, 24 Jul 2026 11:37:09 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13e0f4a039asm49194c88.9.2026.07.24.11.37.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 11:37:08 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, matheus.bernardino@oss.qualcomm.com, 
 philmd@oss.qualcomm.com, Brian Cain <brian.cain@oss.qualcomm.com>,
 pierrick.bouvier@oss.qualcomm.com, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 14/14] tests/functional/hexagon: enable more arch_tests
 cases
Date: Fri, 24 Jul 2026 11:36:48 -0700
Message-Id: <20260724183648.190531-15-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260724183648.190531-1-brian.cain@oss.qualcomm.com>
References: <20260724183648.190531-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: UINTFsJZtq3gZ1t_fBEXzTWMVRIY8QcF
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDE2NyBTYWx0ZWRfX21veqQOiYwq7
 Yvm29JWCwONq8fbya8Gj804YNeLVWfPaFPRqKUt2jvUWGtsv5vEjT3meIhk1wiYI/vkcpdRaoy6
 A5TDuRcDNGdgfYKROvq6ro0MbZ6DvRw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDE2NyBTYWx0ZWRfXzotxCLfkq66o
 mRyutai4lPunhAvx2hXRUkbWsJ9tPc8+ocpbHl07ar2NwlH8NTiJBsjU6/EI4BI2E8Un/GcTG3h
 sOjqMTGD0NvA+Yv8fQmlQZRF1kdi/eJ7eHRhKGDD7938o/rbepLs4rXDwUEvnycEp7XFQU0dz2J
 O61W717EZiCkVXO+hssFCM8uHjLGTny1IvLjmnAF96ilUcgqzBRLMca8j/HKnihqpa92WldIBx2
 Aai8QFeTFvVpNGdVUoRtwN/4ZHXPw2gqY7eoIbwX0k5RgfAxj0f4pzgXzyLOJPlrQy50E6yJMuy
 9/g1WXgjBD6aFbYnuqiCE3tVxTj5jLkfGG37rgPXZM6PI/cmrCeQldRPEjyLwBbAnHm2wwjjsQP
 OATNeGUOlAVg3i4LP5wnHgz9c5G9lLfGI+zxoolCoEJ6Ck+erOnmBapc7iDFZbf18McEQ7nV0j+
 bRWKxRPc2X69tNHstkw==
X-Proofpoint-ORIG-GUID: UINTFsJZtq3gZ1t_fBEXzTWMVRIY8QcF
X-Authority-Analysis: v=2.4 cv=bOUm5v+Z c=1 sm=1 tr=0 ts=6a63b0d6 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=6_sklNI9eh_OQcpcNH0A:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 suspectscore=0 clxscore=1015 adultscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607240167
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

QWRkIG1vcmUgdGVzdHMgZnJvbSBoZXhhZ29uLWFyY2gtdGVzdHMsIGVuYWJsZWQgYnkgUVRpbWVy
IGRldmljZS4KClRoZXNlIGV4ZXJjaXNlIGNhY2hlIG1haW50ZW5hbmNlIG9wcywgbDJ2aWMsIHRo
cmVhZCBzdGFydC9zdG9wLCB0bGIvbW11Cm9wZXJhdGlvbnMsIGFuZCB1c2VyLW1vZGUgdHJhbnNp
dGlvbnMuCgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29t
bS5jb20+Ci0tLQogdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL3Rlc3RfYXJjaF90ZXN0cy5weSB8
IDMyICsrKysrKysrKysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDMyIGluc2VydGlvbnMo
KykKCmRpZmYgLS1naXQgYS90ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9hcmNoX3Rlc3Rz
LnB5IGIvdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL3Rlc3RfYXJjaF90ZXN0cy5weQppbmRleCAy
YmIzNGY5YjhkYy4uMDgzNDM5OGMzYjEgMTAwNzU1Ci0tLSBhL3Rlc3RzL2Z1bmN0aW9uYWwvaGV4
YWdvbi90ZXN0X2FyY2hfdGVzdHMucHkKKysrIGIvdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL3Rl
c3RfYXJjaF90ZXN0cy5weQpAQCAtNTgsNiArNTgsMzggQEAgZGVmIHRlc3RfaW50X3N0ZWVyaW5n
KHNlbGYpIC0+IE5vbmU6CiAgICAgICAgICIiIgogICAgICAgICBzZWxmLnJ1bl91YXJ0X3Rlc3Qo
InRlc3RfaW50X3N0ZWVyaW5nIikKIAorICAgIGRlZiB0ZXN0X2NhY2hlKHNlbGYpIC0+IE5vbmU6
CisgICAgICAgICIiIlRlc3RzIGNhY2hlIG9wZXJhdGlvbnM6IGRja2lsbC9pY2tpbGwsIGwya2ls
bCwgZGN6ZXJvYSwKKyAgICAgICAgZGNjbGVhbmludmEsIGNhY2hlIGRpc2FibGUvZW5hYmxlLCBi
YXJyaWVycywgYW5kIGRjaW52YS9kY2NsZWFuYS4KKyAgICAgICAgIiIiCisgICAgICAgIHNlbGYu
cnVuX3VhcnRfdGVzdCgidGVzdF9jYWNoZSIpCisKKyAgICBkZWYgdGVzdF9sMnZpYyhzZWxmKSAt
PiBOb25lOgorICAgICAgICAiIiJUZXN0cyB0aGUgTDJWSUMgaW50ZXJydXB0IGNvbnRyb2xsZXI6
IGVuYWJsZSByZWFkYmFjaywKKyAgICAgICAgaW50ZXJydXB0IHR5cGUgcmVhZGJhY2ssIFZJRCBj
YXB0dXJlLCBhbmQgdGhlIGZhc3QgaW50ZXJmYWNlLgorICAgICAgICAiIiIKKyAgICAgICAgc2Vs
Zi5ydW5fdWFydF90ZXN0KCJ0ZXN0X2wydmljIikKKworICAgIGRlZiB0ZXN0X3RocmVhZHMoc2Vs
ZikgLT4gTm9uZToKKyAgICAgICAgIiIiVGVzdHMgaGFyZHdhcmUgdGhyZWFkIG1hbmFnZW1lbnQ6
IHN0YXJ0L3N0b3AsIE1PREVDVEwgc3RhdGUsCisgICAgICAgIHBlci10aHJlYWQgSFRJRCwgc2hh
cmVkIG1lbW9yeSwgd2FpdC9yZXN1bWUsIFNUSUQgcHJpb3JpdHksIGFuZAorICAgICAgICBTQ0hF
RENGRy9CRVNUV0FJVCByZWFkYmFjay4KKyAgICAgICAgIiIiCisgICAgICAgIHNlbGYucnVuX3Vh
cnRfdGVzdCgidGVzdF90aHJlYWRzIikKKworICAgIGRlZiB0ZXN0X3RsYl9tbXUoc2VsZikgLT4g
Tm9uZToKKyAgICAgICAgIiIiVGVzdHMgVExCL01NVSBvcGVyYXRpb25zOiB3cml0ZS9yZWFkL3By
b2JlL2ludmFsaWRhdGUsCisgICAgICAgIGdsb2JhbCBlbnRyaWVzLCBtdWx0aXBsZSBlbnRyaWVz
LCBvdmVyd3JpdGUsIEFTSUQgbWF0Y2hpbmcsCisgICAgICAgIGFuZCBwZXJtaXNzaW9uIGNoZWNr
cy4KKyAgICAgICAgIiIiCisgICAgICAgIHNlbGYucnVuX3VhcnRfdGVzdCgidGVzdF90bGJfbW11
IikKKworICAgIGRlZiB0ZXN0X3VzZXJfbW9kZShzZWxmKSAtPiBOb25lOgorICAgICAgICAiIiJU
ZXN0cyB1c2VyIG1vZGUgLyBwcml2aWxlZ2UgdHJhbnNpdGlvbnM6IHN1cGVydmlzb3IgbW9kZSwK
KyAgICAgICAgU1NSIFVNL0lFL1hFL0NFL1BFIGJpdHMsIGFuZCB0aGUgdHJhcDAgdXNlci1tb2Rl
IGV4aXQgaGFuZGxlci4KKyAgICAgICAgIiIiCisgICAgICAgIHNlbGYucnVuX3VhcnRfdGVzdCgi
dGVzdF91c2VyX21vZGUiKQorCiAKIGlmIF9fbmFtZV9fID09ICJfX21haW5fXyI6CiAgICAgUWVt
dVN5c3RlbVRlc3QubWFpbigpCi0tIAoyLjM0LjEKCg==

