Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E279C624DB
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2026 20:07:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2weL-0001Ua-3D; Sat, 05 Sep 2026 16:06:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x2weI-0001UJ-37
 for qemu-devel@nongnu.org; Sat, 05 Sep 2026 16:06:02 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x2weG-00061A-GV
 for qemu-devel@nongnu.org; Sat, 05 Sep 2026 16:06:01 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 685HavkI4114306
 for <qemu-devel@nongnu.org>; Sat, 5 Sep 2026 20:05:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Xmh6YCOnOhdXFJxX0E9hs5n1b/oo+mS+fqAPQNeqqkQ=; b=DPdw7Nx5uJW8ES40
 xxxRKcLcSox+qAkRMqCboAR4EZ1bf8aesORye+0igXF9Spupe4WE6vAbBxWqkiIv
 FBHsF+CGPle4smTw7F6lru9yBeIh9KOSHK3MYJUC8DKdzjl7umkzoSxgYSLzQeZQ
 1rZQAf2iYMqSXNi4wu5aAQHDPIa0WHYsljDSlyA0d1TMmrE4C2bgKQG+MUBhQdWt
 S7+h06u6Ef4TBiBNGCTnKqTlj/Qy6smTpjdhIe5VoAhCok9/9B2Qkukaotzd9dCr
 gN/WXUciVwsnqHNq88SsFZpajp3jxMzQ0ucmU8+7P0E9WG23EPXUFdNXCKAjQbnM
 jdgwQg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gg8sd2k8e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2026 20:05:58 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cc1d85c012dso3689860a12.2
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2026 13:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788638758; x=1789243558; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Xmh6YCOnOhdXFJxX0E9hs5n1b/oo+mS+fqAPQNeqqkQ=;
 b=YPmpytkbXj3wnPDMwRD3VsmRQEpaaTXCkGVqXyIuIctG8zQw82Vts/kqsGildpdlUf
 M79uhSdVx5Tfz1g/2XMGjk0FouyMogevNcRVeMsdPqJkf5+Nl+ESN/hqCeylAcURhScc
 dMbdq06slU6vcIjrask4IdmPkYK/7WO3WaU4eplZ+6jKC1MsvUTA708KSU8jyOWOsNgf
 i/NfVSqG3GePYf8oxMRmwc9EaMjKWM8kie3dXAG5MoNRFGM66sMtw757pN8Onvbi2unM
 iutVyNGJdvtv0p7PjNH/PBKSlyTuBiLGnfXvVrdXDr91igaNlXMYx8MseRvmo3USeAiI
 OHGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788638758; x=1789243558;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Xmh6YCOnOhdXFJxX0E9hs5n1b/oo+mS+fqAPQNeqqkQ=;
 b=s7aEoJPqpg/BQxXTTsaoaSN4XTrfenlwDXRqQVFK5iDdtDrZv1oKG8XGcntFzDtxHI
 1KbIAKNjguDYsT0iMIYpD8Wc3nVAjtzJIiEA8ecyLfrrDNQqrrx3OsbRMnOiofWw47Je
 Y031B2oHqbcNXSf5+NyDkEdgmB27qODAO1efc0P846IAgi75yjNSa1r31gBLOeT+4Ip2
 5UT9+oQE2ijsVE6LTD6PmRqXk43JxeQcNZQCX4Ty/ha6wgfeUYPadc1kRfgAJH2LVGAS
 pCgAaWiqLTcR4lI0VYww2NvYxbtIUW3LlqvEu2biLtXie+Bn60Id3gDDP81c40u1GAXn
 FLZA==
X-Gm-Message-State: AFuF++kpZqcakKPa1Mj25edMr2+aV5q2EoYC7ZACl5KM1JMY0AKUOa/g
 XA2Q2dzJkxzIh2LaYU7wF30IOmOf5rDwO0tKYWXozUSF+RUKmUgtqQ8SrMGYCvOJJx0FG0cWadN
 BAs10m473lanoroK1QvvELM4/iFr4/F0x2p9ZE+SfxrjMYJg+aLL+ZosvdRjGxRdfag==
X-Gm-Gg: AYBFou3xmr5iVYdxcXUAlP4LCigWsvuu929si3oZ8Ii0RnXL3misrJhqRIpxAQygioT
 9kR8YzBE6oWDj4NfN9ZFLebx1weYq3BlwUVeHjqmrHiWjv58WPJL8BHCC7Cz/p1E4keGFsyr2RJ
 Uxc0LFRb135R/UkPh+7DMjjl5dvoJfKDjahfVC2f4RKdLfcs1h/usq6t+Dnolm2yqI0Wdup7VV+
 MlmqVNA+fBgbPmkjhzbaOSxqzWm/mW84GlUFPNH/0z5SdZ16kY3PF6HCh3Z7/9plhRQRSeNDoXh
 O+GGpOCHlJ3eKa9iClMH3gywvWonp95yZaDZiyv4o2oIcvXX8PPac5c8gVE3/YjkVMfgWX6ob4j
 pzOis6btEDeTYenVTEfwOItq4nYtJnH8i3Ht/9qc6nJC+Kl11
X-Received: by 2002:a05:6a20:729e:b0:3d0:d1f1:6ec5 with SMTP id
 adf61e73a8af0-3da39bb5957mr20302333637.4.1788638758130; 
 Sat, 05 Sep 2026 13:05:58 -0700 (PDT)
X-Received: by 2002:a05:6a20:729e:b0:3d0:d1f1:6ec5 with SMTP id
 adf61e73a8af0-3da39bb5957mr20302288637.4.1788638757664; 
 Sat, 05 Sep 2026 13:05:57 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339bbebf2fsm17346075eec.25.2026.09.05.13.05.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2026 13:05:57 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 3/9] target/hexagon: kick vCPU when re-asserting interrupts
Date: Sat,  5 Sep 2026 13:05:44 -0700
Message-Id: <20260905200550.2009799-4-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260905200550.2009799-1-brian.cain@oss.qualcomm.com>
References: <20260905200550.2009799-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: 8RHl9-NZfI6ZCRew9DBzOd1mg3kGKlcp
X-Proofpoint-ORIG-GUID: 8RHl9-NZfI6ZCRew9DBzOd1mg3kGKlcp
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA1MDIyMyBTYWx0ZWRfX7lytheMBhB0t
 YJqfkRWf4GVmEqyRJTIJbkxSMIg8amiRNdazK4+dsom6MRLCigE0O5AcG9wj3V1qgQmVtZu3Dnr
 sN3TdbZIhysFpgl+rTa5ppshfjJ7mPg=
X-Authority-Analysis: v=2.4 cv=dfmwG3Xe c=1 sm=1 tr=0 ts=6a9c7626 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=_cPWo3-z87wpK2aiiYgA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA1MDIyMyBTYWx0ZWRfX3r1dEXEl8fq1
 SkTJKb6CpGcZHdS+jHa8tZgIyrRcRsCiuFPUgonPcfXrWmfOzwbHK5XNOvK0W+AtW7DT5HQTLth
 6kKGNe+Z0H1yO0J5Bd5jgUXqZ3CSnYPh3Jr5JsAO1a8N1qRY83L7d/4EI/25RzulhyqOeVPbv+u
 FHq1r4kh0bHZ2fQNsjXO2T/8FBZTaw1XBeoeHl5U/I2xAecPN1fJ8P5Zht76SULr2YeYx3+xPMW
 QWf3TN6wkAa/zOw/xBPHGVB+dYWlySY4mUmcXMVSA1g6gEV/F3OGdUQIPlgkHqbquL+5v0V9K7I
 SOXEzKBl05c5h+QACAxBqNiW8VE7SEz2a4vOWSBXEYvkz5aQZ0B+AJi1tjr6bbhoWCOOjcyzzgP
 fCoAbxx8mEX4ej9uAD5iMs0FrZGnl6fckqpQprE1sjUsfn1sxZ79Ls4AkxODF9ZP7Jj4wgTEI5b
 SGrA5HoQQ5nQhcR1b8A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-05_06,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609050223
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

aGV4X2ludGVycnVwdF91cGRhdGUoKSB1c2VkIGNwdV9yZXN1bWUoKSB0byBtYWtlIGEgaGFsdGVk
IHZDUFUgbm90aWNlIGEKbmV3bHkgcGVuZGluZyBpbnRlcnJ1cHQuICBjcHVfcmVzdW1lKCkgaXMg
bWVhbnQgZm9yIGEgdkNQVSBzdG9wcGVkIGJ5IHRoZQp2bS1zdGF0ZSBtYWNoaW5lcnk6IGJlc2lk
ZXMga2lja2luZyB0aGUgdGhyZWFkIGl0IGNsZWFycyBjcHUtPnN0b3AgYW5kCmNwdS0+c3RvcHBl
ZCwgYW5kIHJlc2V0cyBleGNlcHRpb25faW5kZXggdG8gLTEuICBDbGVhcmluZyB0aGUgc3RvcCBm
bGFncwpjYW4gdW5kbyBhIHBhdXNlIHJlcXVlc3RlZCB2aWEgdGhlIG1vbml0b3Igb3IgYnkgbWln
cmF0aW9uLCBhbmQgcmVzZXR0aW5nCmV4Y2VwdGlvbl9pbmRleCBkaXNjYXJkcyBhbiBleGNlcHRp
b24gdGhlIHZDUFUgaGFkIGFscmVhZHkgbGF0Y2hlZC4KCk9ubHkgdGhlIGtpY2sgaXMgd2FudGVk
IGhlcmUsIHNvIGNhbGwgcWVtdV9jcHVfa2ljaygpIGRpcmVjdGx5LgoKUmV2aWV3ZWQtYnk6IFBp
ZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAb3NzLnF1YWxjb21tLmNvbT4KU2lnbmVk
LW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRh
cmdldC9oZXhhZ29uL2hleF9pbnRlcnJ1cHRzLmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9o
ZXhfaW50ZXJydXB0cy5jIGIvdGFyZ2V0L2hleGFnb24vaGV4X2ludGVycnVwdHMuYwppbmRleCA3
ZGRlMTI5NGIyZS4uMmIyODM0YWY5NWYgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2hleF9p
bnRlcnJ1cHRzLmMKKysrIGIvdGFyZ2V0L2hleGFnb24vaGV4X2ludGVycnVwdHMuYwpAQCAtNDQx
LDcgKzQ0MSw3IEBAIHZvaWQgaGV4X2ludGVycnVwdF91cGRhdGUoQ1BVSGV4YWdvblN0YXRlICpl
bnYpCiAgICAgICAgICAgICBjb25zdCBpbnQgZXhlX21vZGUgPSBnZXRfZXhlX21vZGUoaGV4X2Vu
dik7CiAgICAgICAgICAgICBpZiAoZXhlX21vZGUgIT0gSEVYX0VYRV9NT0RFX09GRikgewogICAg
ICAgICAgICAgICAgIGNwdV9pbnRlcnJ1cHQoY3MsIENQVV9JTlRFUlJVUFRfU1dJKTsKLSAgICAg
ICAgICAgICAgICBjcHVfcmVzdW1lKGNzKTsKKyAgICAgICAgICAgICAgICBxZW11X2NwdV9raWNr
KGNzKTsKICAgICAgICAgICAgIH0KICAgICAgICAgfQogICAgIH0KLS0gCjIuMzQuMQoK

