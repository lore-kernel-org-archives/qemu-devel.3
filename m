Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83FE3C79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 13:35:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3vzG-0004fE-Ec; Tue, 08 Sep 2026 09:35:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x3vzE-0004cY-B0
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 09:35:44 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x3vyr-0006Et-St
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 09:35:43 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 688CksrZ3013087
 for <qemu-devel@nongnu.org>; Tue, 8 Sep 2026 13:35:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 h/3kdVRW9U0MaI4U5a4Wnb8rysC4oI02ASU5moYQj0U=; b=mmV7ei6x92us09zz
 UvBYVBW2mNNxviQyoMBdlBDYhSRz8Qx+fLas31vz4Nk+Wt/FbOlinAX/l+W3zbn/
 itOH2fLot6fsCH5wDH6VGzjhN7+TLohL+ym+jdpNmNTUXi6NgKO1pII+YSpcW3aM
 IupssmpI62Bk9EFveJ98RF687GDW7pJa8hdnkSsyIt+FqAVE9IzngnaPWqIZMTdr
 ZGUN0F9vW4u9bCdpQljrQvDvtTjOIhDeY+8VAytkQHnvOCrQmzbQcuEChh2EjZ7d
 dyqTtyXDGU05/Uf/m9ejQeygcPmFwsQF9fzUyrP0GuenEhJUzhpcjxgi3RXXbXkY
 vtPjwg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gj1rwkp3h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 13:35:20 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38e54b6556aso1506454a91.2
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 06:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788874519; x=1789479319; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=h/3kdVRW9U0MaI4U5a4Wnb8rysC4oI02ASU5moYQj0U=;
 b=Z7FvsTMwh/qtlvlAGtWYzzPD2DxXBwvqQQYLabf7Bh17DcgSN/u3qzkKix1wLhzaGe
 T7u2DqJuxl8zC88tOsq59vKuPTlNPxU8HvSvuPjCC8n24dyi0gayOia56oBpbqPhEkW2
 jxKRI4m2irR82ko1p7+KKeoE/cVpYi5rszgZ1gtGPW+6tn+Gx1vK3TWsNi2mJ883rZ+a
 PH637M8WcQK+D8O9+aJYdaNH+cyf3+Sl1KqfYS5KOoWGRFPheK1Bg8YnBBgREzKQfGO/
 SRgayWmVuauOjIul9VFn/tsodBtxyM4iNrWYopu1cGisDCqaSfTIsQjYjudnBMyUWZD0
 4K6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788874519; x=1789479319;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=h/3kdVRW9U0MaI4U5a4Wnb8rysC4oI02ASU5moYQj0U=;
 b=YC51Uwwc8N1jJ55h/WW5+DKsAnZ/4X4wWzem1tnLggBdvnoc3FhYxTcWz9retA0IjF
 MZZsrI5+QsxIfn0mCsOAVv//yrThRzf81BwvcxlfrmGtyV95qFR2kKFg622lmqEDdfIG
 6aeQUg7TyJvZXCkp6F10yIGmBNhCQ4vjVftZ9Qh9wpNNRo96dx5B64YUR/UUhhRDv5Ui
 GZ4MxeonkDjKut8EQFwT4eA/9PNONTspW9+4UMfEr1UO40bqkk+jLjTyzB9SHdj1aTUo
 iC6V5dlzBPXPGw8MZADTdY5CKDGzrD/tQmaVuE3FIoBUm8tnyvxI1zu8X736Jufq0RmW
 sMUA==
X-Gm-Message-State: AFuF++kJDrEkjsvr9PeiGc6SQIRiYSlBqvznUf3OEyWanGX5v3R+JKD8
 4IebfnDqTNxKoUt3CvA8QjJZFkpQ5eHH6gb0orvOptKriIBpwWriKg8rw5VyjUQR4uN7c4K41Ml
 JPuJI3LCFX5sqgQscLudIWd+w9WMqJiUb2fBpAeW3iFg6TYb8oiat5T4jnFsFMT3qOw==
X-Gm-Gg: AYBFou1dJBsMB8VvK2Hy3RjxNBGl+JdWB41xuSF3XxR5CwbMO584OS4xRjQHmW6fvjO
 Gc3VKr4ZU/W4ujTD5EGCZ13HEPHwz4FM4+X3gCE6QRDDrfXJtQ2MklxFkpmkktD6HG753mn/MEt
 iWcj0veI2KuRvTZcTJpLTi1wHhr59ZBaTcNT5TDkYwOG2EebttqEl0nJiBJ8mtbqz3JEVf8A2wR
 NBncm3CLYy9gtYnZk/9/zwUwBGUbuijgEn8G57Rg+wYOIyHPuCxRdE2t6vn/BttEjEYTN1ByYkT
 avATIb/NibBzBKYR4D2RsQJgPOHOxC6pykkwfAt8iyeExXbOyyKD5auEeYiwMFH0fGqe3ki9YlJ
 1vk78ky3XDN7F/AzWSkRY3p9vwxppNDg8Aubroslnh+7o54Uv
X-Received: by 2002:a17:90b:258d:b0:396:4c63:7193 with SMTP id
 98e67ed59e1d1-39b261323e0mr47106976a91.11.1788874519217; 
 Tue, 08 Sep 2026 06:35:19 -0700 (PDT)
X-Received: by 2002:a17:90b:258d:b0:396:4c63:7193 with SMTP id
 98e67ed59e1d1-39b261323e0mr47106899a91.11.1788874518717; 
 Tue, 08 Sep 2026 06:35:18 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-334fbd5e6f6sm29029079eec.23.2026.09.08.06.35.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 06:35:16 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 marco.liebel@oss.qualcomm.com
Subject: [PATCH 2/5] target/hexagon: add the v73 J2_unpause scalar instruction
Date: Tue,  8 Sep 2026 06:35:08 -0700
Message-Id: <20260908133512.2353957-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260908133512.2353957-1-brian.cain@oss.qualcomm.com>
References: <20260908133512.2353957-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=Ga8nWwXL c=1 sm=1 tr=0 ts=6aa00f18 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=fnvyaJKH3I3DEN-d1BkA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE0NSBTYWx0ZWRfX17A27VJI9sCi
 WgjE+8NUS5TjfoBbT0ROvicsKMkaE+OrevHPuh+TnUZ13AxmCKrkrX+s4Cu5lGj85kFvAaFtzmC
 /qRNA6zJZCCswY/YP7v0Qq8rAgn7a05J6hT/69Q+N1XNdVus+QDQ1KJ9xKHqSg/bsP+V5jLGH1x
 m6fNwry4go78uWw3EE78s0EY1yxE11zcDPEqniXsuceMWD819ZnM/aL1OBjxzfuIAjSlBcWF36s
 yLVPvyDfyYeEmwM6zTcqjmE5rM44mImtND2NiRjl3+4lNlkmsAggUjBNi3qY0jH8CmlaTm2vWRv
 D7607lM5qX8BxiU/oL8mKNcloKkiVcvdR9M16xtrpMO1VsEnfI7c1lAAmPesKgdTt6Pp8XkW3Pl
 NoiFskgKV5tfX2MTJSf/WYMAQSKWepunOGFKhDDvuqdNnq/z3KzJ0qOulb9VlfSWFoUCUvLVYqa
 3FX4k3Un+BCYZCOdwaw==
X-Proofpoint-ORIG-GUID: gbazMaGknXJiez0LqLN1IlYnd5NE-RXx
X-Proofpoint-GUID: gbazMaGknXJiez0LqLN1IlYnd5NE-RXx
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE0NSBTYWx0ZWRfX4zh9q/3MG+nk
 7M8Bi42Ie2C+Stpay4QRTf+/EKTOUpbNTeOMvVVvKBQW7LN8bpi8ySp4I3g9XZWZJRTgPsR+yTJ
 /qhPKdGKka32WqNoUtbYK4iNDp0wVck=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_02,2026-09-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080145
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

djczIGFscmVhZHkgYWRkZWQgSjJfY2FsbHJoIGFuZCBKMl9qdW1wcmggYnV0IHVuaW50ZW50aW9u
YWxseQpvbWl0dGVkIGB1bnBhdXNlYC4gIEl0cyBlZmZlY3QgaXMgdG8gY2F1c2Ugb3RoZXIgdGhy
ZWFkcycgcGF1c2UKaW5zdHJ1Y3Rpb25zIHRvIGNlYXNlIHBhdXNpbmcsIGJ1dCB3ZSB0cmVhdCBg
cGF1c2VgIGFzIGEgbm9wIG9yCmEgeWllbGQgaW4gUlIsIHNvIHVucGF1c2UgY2FuIHNhZmVseSBi
ZSBhIG5vcC4KCldoaWxlIGhlcmUsIHNwZWxsIHRoZSBvdGhlciB0d28gdjczIGVudHJpZXMnIHZl
cnNpb24gYXMgSEVYX1ZFUl9WNzMKaW5zdGVhZCBvZiB0aGUgbGl0ZXJhbCAweDczLCBtYXRjaGlu
ZyBldmVyeSBvdGhlciBlbnRyeSBpbiB0aGUgdGFibGUuCgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBD
YWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGVzdHMvdGNnL2hleGFnb24v
Y2hlY2tfcmV2X2dhdGluZy5jICB8IDEyICsrKysrKysrKy0tLQogdGVzdHMvdGNnL2hleGFnb24v
djczX3NjYWxhci5jICAgICAgICB8ICA3ICsrKysrKysKIHRhcmdldC9oZXhhZ29uL3RhZ19yZXZf
aW5mby5jLmluYyAgICAgfCAgNSArKystLQogdGFyZ2V0L2hleGFnb24vaW1wb3J0ZWQvZW5jb2Rl
X3BwLmRlZiB8ICAxICsKIHRhcmdldC9oZXhhZ29uL2ltcG9ydGVkL3N5c3RlbS5pZGVmICAgfCAg
MyArKysKIDUgZmlsZXMgY2hhbmdlZCwgMjMgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkK
CmRpZmYgLS1naXQgYS90ZXN0cy90Y2cvaGV4YWdvbi9jaGVja19yZXZfZ2F0aW5nLmMgYi90ZXN0
cy90Y2cvaGV4YWdvbi9jaGVja19yZXZfZ2F0aW5nLmMKaW5kZXggMjZiNjZmNTQ1NTIuLmQ1Mjk1
YmYyNGFiIDEwMDY0NAotLS0gYS90ZXN0cy90Y2cvaGV4YWdvbi9jaGVja19yZXZfZ2F0aW5nLmMK
KysrIGIvdGVzdHMvdGNnL2hleGFnb24vY2hlY2tfcmV2X2dhdGluZy5jCkBAIC0zLDkgKzMsMTIg
QEAKICAqIGFyZSByZWplY3RlZCB3aXRoIFNJR0lMTC4KICAqCiAgKiBDb21waWxlZCB3aXRoIC1t
djY2IHNvIHRoYXQgZV9mbGFncyBzZWxlY3RzIENQVSB2NjYuIFRoZSB0ZXN0IGVtYmVkcwotICog
YSB2NjggaW5zdHJ1Y3Rpb24gKEwyX2xvYWR3X2FxOiAicjAgPSBtZW13X2FxKHIwKSIpIHZpYSAu
d29yZAotICogZW5jb2RpbmcuIFRoZSByZXZpc2lvbi1nYXRlZCBkZWNvZGVyIG11c3QgcmVqZWN0
IGl0LCBhbmQgbGludXgtdXNlcgotICogbXVzdCBkZWxpdmVyIFNJR0lMTC4KKyAqIGluc3RydWN0
aW9ucyBmcm9tIHY2OCB0aHJvdWdoIHY3MyB2aWEgLndvcmQgZW5jb2Rpbmc6IHRoZSBhc3NlbWJs
ZXIKKyAqIGVuZm9yY2VzIHRoZSBzZWxlY3RlZCBDUFUncyBvd24gbWluaW11bSB2ZXJzaW9uLCBz
byBub25lIG9mIHRoZXNlIC0tCisgKiBpbmNsdWRpbmcgb25lcyBpdCBvdGhlcndpc2Uga25vd3Mg
aG93IHRvIGFzc2VtYmxlIGF0IHRoZWlyIG93bgorICogdGFyZ2V0LCBzdWNoIGFzIGNhbGxyaCBv
ciB1bnBhdXNlIC0tIGNhbiBiZSB3cml0dGVuIGFzIHRoZW1zZWx2ZXMgaW4KKyAqIGEgZmlsZSBi
dWlsdCBmb3IgdjY2LiBUaGUgcmV2aXNpb24tZ2F0ZWQgZGVjb2RlciBtdXN0IHJlamVjdCBldmVy
eQorICogb25lIG9mIHRoZW0sIGFuZCBsaW51eC11c2VyIG11c3QgZGVsaXZlciBTSUdJTEwuCiAg
KgogICogQ29weXJpZ2h0IChjKSBRdWFsY29tbSBUZWNobm9sb2dpZXMsIEluYy4gYW5kL29yIGl0
cyBzdWJzaWRpYXJpZXMuCiAgKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1s
YXRlcgpAQCAtMTAyLDYgKzEwNSw4IEBAIFRSWV9GVU5DKHY3M19jYWxscmgsCiAgICAgICAgICAi
LndvcmQgMHg1MGM1YzAwMCAgICAvKiBjYWxscmggcjUgKi9cbiIpCiBUUllfRlVOQyh2NzNfanVt
cHJoLAogICAgICAgICAgIi53b3JkIDB4NTJjMGMwMDAgICAgLyoganVtcHJoIHIwICovXG4iKQor
VFJZX0ZVTkModjczX3VucGF1c2UsCisgICAgICAgICAiLndvcmQgMHg1N2UwZDAwMCAgICAvKiB1
bnBhdXNlICovXG4iKQogCiBpbnQgbWFpbih2b2lkKQogewpAQCAtMTMzLDYgKzEzOCw3IEBAIGlu
dCBtYWluKHZvaWQpCiAKICAgICBhc3NlcnQodHJ5X3Y3M19jYWxscmgoKSA9PSBTSUdJTEwpOwog
ICAgIGFzc2VydCh0cnlfdjczX2p1bXByaCgpID09IFNJR0lMTCk7CisgICAgYXNzZXJ0KHRyeV92
NzNfdW5wYXVzZSgpID09IFNJR0lMTCk7CiAKICAgICBhc3NlcnQoc2lnbmFsc19oYW5kbGVkID09
IGV4cGVjdGVkX3NpZ25hbHMpOwogCmRpZmYgLS1naXQgYS90ZXN0cy90Y2cvaGV4YWdvbi92NzNf
c2NhbGFyLmMgYi90ZXN0cy90Y2cvaGV4YWdvbi92NzNfc2NhbGFyLmMKaW5kZXggZmVlNjdmYzUz
MTEuLjJiNWYzYWEyMTQ5IDEwMDY0NAotLS0gYS90ZXN0cy90Y2cvaGV4YWdvbi92NzNfc2NhbGFy
LmMKKysrIGIvdGVzdHMvdGNnL2hleGFnb24vdjczX3NjYWxhci5jCkBAIC04NiwxMCArODYsMTcg
QEAgc3RhdGljIHZvaWQgdGVzdF9qdW1wcmgodm9pZCkKICAgICBjaGVjazMyKHJlcywgMSk7CiB9
CiAKK3N0YXRpYyB2b2lkIHRlc3RfdW5wYXVzZSh2b2lkKQoreworICAgIC8qIE5vdGhpbmcgaXMg
cGF1c2VkLCBzbyB0aGlzIGp1c3QgbmVlZHMgdG8gZXhlY3V0ZSB3aXRob3V0IGZhdWx0aW5nLiAq
LworICAgIGFzbSB2b2xhdGlsZSgidW5wYXVzZVxuXHQiKTsKK30KKwogaW50IG1haW4oKQogewog
ICAgIHRlc3RfY2FsbHJoKCk7CiAgICAgdGVzdF9qdW1wcmgoKTsKKyAgICB0ZXN0X3VucGF1c2Uo
KTsKIAogICAgIHB1dHMoZXJyID8gIkZBSUwiIDogIlBBU1MiKTsKICAgICByZXR1cm4gZXJyID8g
MSA6IDA7CmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi90YWdfcmV2X2luZm8uYy5pbmMgYi90
YXJnZXQvaGV4YWdvbi90YWdfcmV2X2luZm8uYy5pbmMKaW5kZXggYTkxYjkxYTIzZTYuLjQ0NTEz
ZjQ2ODA5IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi90YWdfcmV2X2luZm8uYy5pbmMKKysr
IGIvdGFyZ2V0L2hleGFnb24vdGFnX3Jldl9pbmZvLmMuaW5jCkBAIC01NzEsOCArNTcxLDkgQEAg
c3RhdGljIGNvbnN0IHN0cnVjdCB0YWdfcmV2X2luZm8gdGFnX3Jldl9pbmZvW1hYX0xBU1RfT1BD
T0RFXSA9IHsKICAgICBbRjJfZGZtcHloaF0gPSB7IC5pbnRyb2R1Y2VkID0gSEVYX1ZFUl9WNjcs
IC5yZW1vdmVkID0gSEVYX1ZFUl9OT05FIH0sCiAgICAgW0YyX2RmbXB5bGhdID0geyAuaW50cm9k
dWNlZCA9IEhFWF9WRVJfVjY3LCAucmVtb3ZlZCA9IEhFWF9WRVJfTk9ORSB9LAogICAgIFtGMl9k
Zm1weWxsXSA9IHsgLmludHJvZHVjZWQgPSBIRVhfVkVSX1Y2NywgLnJlbW92ZWQgPSBIRVhfVkVS
X05PTkUgfSwKLSAgICBbSjJfY2FsbHJoXSA9IHsgLmludHJvZHVjZWQgPSAweDczLCAucmVtb3Zl
ZCA9IEhFWF9WRVJfTk9ORSB9LAotICAgIFtKMl9qdW1wcmhdID0geyAuaW50cm9kdWNlZCA9IDB4
NzMsIC5yZW1vdmVkID0gSEVYX1ZFUl9OT05FIH0sCisgICAgW0oyX2NhbGxyaF0gPSB7IC5pbnRy
b2R1Y2VkID0gSEVYX1ZFUl9WNzMsIC5yZW1vdmVkID0gSEVYX1ZFUl9OT05FIH0sCisgICAgW0oy
X2p1bXByaF0gPSB7IC5pbnRyb2R1Y2VkID0gSEVYX1ZFUl9WNzMsIC5yZW1vdmVkID0gSEVYX1ZF
Ul9OT05FIH0sCisgICAgW0oyX3VucGF1c2VdID0geyAuaW50cm9kdWNlZCA9IEhFWF9WRVJfVjcz
LCAucmVtb3ZlZCA9IEhFWF9WRVJfTk9ORSB9LAogICAgIFtMMl9sb2Fkd19hcV0gPSB7IC5pbnRy
b2R1Y2VkID0gSEVYX1ZFUl9WNjgsIC5yZW1vdmVkID0gSEVYX1ZFUl9OT05FIH0sCiAgICAgW0w0
X2xvYWRkX2FxXSA9IHsgLmludHJvZHVjZWQgPSBIRVhfVkVSX1Y2OCwgLnJlbW92ZWQgPSBIRVhf
VkVSX05PTkUgfSwKICAgICBbWTZfZG1jZmdyZF0gPSB7IC5pbnRyb2R1Y2VkID0gSEVYX1ZFUl9W
NjgsIC5yZW1vdmVkID0gSEVYX1ZFUl9OT05FIH0sCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdv
bi9pbXBvcnRlZC9lbmNvZGVfcHAuZGVmIGIvdGFyZ2V0L2hleGFnb24vaW1wb3J0ZWQvZW5jb2Rl
X3BwLmRlZgppbmRleCBkOWU4ZWEyYWViZC4uMWZjZTMxOGIyYmIgMTAwNjQ0Ci0tLSBhL3Rhcmdl
dC9oZXhhZ29uL2ltcG9ydGVkL2VuY29kZV9wcC5kZWYKKysrIGIvdGFyZ2V0L2hleGFnb24vaW1w
b3J0ZWQvZW5jb2RlX3BwLmRlZgpAQCAtNTg1LDYgKzU4NSw3IEBAIERFRl9GSUVMRFJPV19ERVND
MzIoSUNMQVNTX0oiIDAxMDAgLS0tLS0tLS0gUFAtLS0tLS0gLS0tLS0tLS0iLCJbIzRdICgjdTgp
ICIpCiBERUZfRU5DMzIoSjJfdHJhcDAsICAgICBJQ0xBU1NfSiIgMDEwMCAgMDAtLS0tLS0gIFBQ
LWlpaWlpICAtLS1paWktLSIpCiBERUZfRU5DMzIoSjJfdHJhcDEsICAgICBJQ0xBU1NfSiIgMDEw
MCAgMTAteHh4eHggIFBQLWlpaWlpICAtLS1paWktLSIpCiBERUZfRU5DMzIoSjJfcGF1c2UsICAg
ICBJQ0xBU1NfSiIgMDEwMCAgMDEtLS0taWkgIFBQLWlpaWlpICAtLS1paWktLSIpCitERUZfRU5D
MzIoSjJfdW5wYXVzZSwiMDEwMTAxMTExMTEtLS0tLVBQMDEtLS0tMDAwLS0tLS0iKQogCiBERUZf
RklFTERST1dfREVTQzMyKElDTEFTU19KIiAwMTAxIC0tLS0tLS0tIFBQLS0tLS0tIC0tLS0tLS0t
IiwiWyM1XSBSZD0oUnMpICIpCiBERUZfRU5DMzIoWTJfaWNkYXRhciwgICBJQ0xBU1NfSiIgMDEw
MSAgMTAxc3Nzc3MgIFBQLS0tLS0tICAtLS1kZGRkZCIpCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4
YWdvbi9pbXBvcnRlZC9zeXN0ZW0uaWRlZiBiL3RhcmdldC9oZXhhZ29uL2ltcG9ydGVkL3N5c3Rl
bS5pZGVmCmluZGV4IDAyYWVlOGNlOGVlLi5iNDRlODc1NjVjMyAxMDA2NDQKLS0tIGEvdGFyZ2V0
L2hleGFnb24vaW1wb3J0ZWQvc3lzdGVtLmlkZWYKKysrIGIvdGFyZ2V0L2hleGFnb24vaW1wb3J0
ZWQvc3lzdGVtLmlkZWYKQEAgLTUxLDYgKzUxLDkgQEAgUTZJTlNOKEoyX3RyYXAxLCJ0cmFwMShS
eDMyLCN1OCkiLEFUVFJJQlMoQV9DT0YsQV9OT1RFX05PUEFDS0VULEFfUkVTVFJJQ1RfTk9QQUMK
IFE2SU5TTihKMl9wYXVzZSwicGF1c2UoI3U4KSIsQVRUUklCUyhBX0NPRixBX05PVEVfTk9QQUNL
RVQsQV9SRVNUUklDVF9OT1BBQ0tFVCksCiAiRW50ZXIgbG93LXBvd2VyIHN0YXRlIGZvciAjdTgg
Y3ljbGVzIix7ZlBBVVNFKHVpVik7fSkKIAorUTZJTlNOKEoyX3VucGF1c2UsInVucGF1c2UiLEFU
VFJJQlMoQV9DT0YsQV9OT1RFX05PUEFDS0VULEFfUkVTVFJJQ1RfTk9QQUNLRVQpLAorIlJlc3Vt
ZSBwYXVzZWQgdGhyZWFkcyIse2ZVTlBBVVNFKCk7fSkKKwogUTZJTlNOKEoyX3J0ZSwgICJydGUi
LCBBVFRSSUJTKEFfUFJJVixBX05PVEVfUFJJVixBX05PX1RJTUlOR19MT0cpLAogIlJldHVybiBm
cm9tIEV4Y2VwdGlvbiIsCiB7Ci0tIAoyLjM0LjEKCg==

