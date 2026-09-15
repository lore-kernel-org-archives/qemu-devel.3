Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D188C88E7F
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 16:33:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6W4X-0006IO-VA; Tue, 15 Sep 2026 12:31:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x6W4O-00063P-MI
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:31:44 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x6W4L-0003sT-GV
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:31:43 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68FFATw24176138
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 16:31:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 eoZnPMfgh/uoiNhVRO9ZE3BANiXO18FNesirNIySkCQ=; b=Kynie+Ol9p7BKuqp
 zMNu6DLKXwXZMJxRJ2is6eYufS5Qny+NeqQ+0ZA1rDnrLdJb1UtmpiNx1lCwaUZP
 sIDNoqw5AOtStO8hpxkIyfTV5oXEZDZy+RWBQw7ljSyxmciiEEYg9+yWvvPLLTSA
 93Rc69bVj3mXfLd38C0IM/8TY8CqS2mBA35DwwC5pCmLzFuWsxtMsSc97niZNNpi
 m5EedLq8Z1TjDcb5rLQAHylL39uojaz1zk5NWdHyGRb9jNwOEJLqfD6N3NzemPMz
 cExOa6E8KkQLrUX7mbtJszztcn5qFzxgGgt2cl5Y830HSookFVAzFI17Y+uvp8/R
 BvGahg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gq3hc2dmx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 16:31:28 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38f283baf1fso5356249a91.3
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 09:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789489888; x=1790094688; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=eoZnPMfgh/uoiNhVRO9ZE3BANiXO18FNesirNIySkCQ=;
 b=SKphvLBAiD/EzP5nEF3FeOIeVoPPiVJanhG0QEPiCLk/FrNg4lsNzq+VvIDsho71g7
 pgTFVKllu2g7kAk5HHpqYx4yjc9su6QEbxwcYatzvt2MCy0dH6v+t4r35KtYPVi75zFa
 30N2MZIqnLgZUu9yuiQ9aRp/osdHbxcPWCIJ7VXv9YcfESoAt6g9tFiPEYKOWZ4S9ch5
 Vka6EizEui/eBhqAYwz9F6fVAd2JoUrnkH8bVWYID2dmQ1MM1HUJpJ0OK50ze0XvW+iR
 brWXjHMNOMIG31+pM1SHhie3HOrsgWlZCY+8QMCQutS3MBWl0XGS4TRHaeAC5haWCWWz
 bQtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789489888; x=1790094688;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eoZnPMfgh/uoiNhVRO9ZE3BANiXO18FNesirNIySkCQ=;
 b=hOagAy9Wi+zpH0owsQdy8pcX8PemCMsb1OPXbogxzX9aEzETmBzsteBo2dt2ye+jWn
 pzeTIhZEGtCNx/WfxylWu0tx/azqspm+aTFf0ou0aFBBMheZvr7uMpyFhsBHL769lM+m
 Ykwogmaf36Hvv0SLvDeAUgrjea+cvAzuUGnupWYsnVZ6JAcv1WTJnHuj5n4jwJDfepSy
 RNaejcPd/e/20icX0Ql/Nm9xxj0+subqjHmrCIr+Z6k2Ul6+3BHE/jB0LokYrbi9NmEy
 yp0ItGCdToV66Nrxxuxjbt1lFn1VZm/q36kFXQa7++WUj9eR+8XZC+0mcrj+eRjRjqmy
 uwQg==
X-Gm-Message-State: AFuF++mS903buuC//oEjfQOwRHjPpLT4F/89nxbg1EI3kqjDiTRrIx8R
 WKU2wWl/rv+VR3exRxhIARCP4+CCoRRkyqRrw9MbR3OQzW9Dgcs3sQF7R1vG8hpHW6Z1I2xMTyu
 DKZue4M++ZG5c+/GnGkOlYjPDyPx9V5ZbEdqwzCnZPHr/V/d74oCc6w9aU5V8D8yMDg==
X-Gm-Gg: AYBFou0lqBorA5xS6RU9L7/vrxz69B/ykEKuXnBpl5bi5kBB1eIZfRf/i+jthb9Zte+
 Gnn39qqKPVY9Dth1f1/BQbU89GMJkKEnCn1udl5IA4v6GmkV+uvbcEG0wF/POxGRENf0/iW6+oc
 bDP/jsAaxYFPwRmG41St3jNz+bwRxF8s41aG82EZ3svSg97VN+SoT8t/AvSEphuxUHIejt9jC2h
 d1JzXy8bYdWhwmgRaHCI89oOBRsYsjt575DlXmjEMmBI+ZPHvL8PLUVxvS7euq1KOn8a3m8okUS
 ZVZFYSxyAaXtWYwD/K8zt6EQyOujv7gybME8MuDKHmfPw6rVttO+LcWyfVJ4648lT+bKRrZ3xZ5
 qCEDRa45DXZiWFN3sPoI1FrozDm4vGrqaW7RiaRPF79tEdGPM
X-Received: by 2002:a17:90b:3f0d:b0:399:1f8b:d255 with SMTP id
 98e67ed59e1d1-39e10c8a755mr3191187a91.5.1789489887420; 
 Tue, 15 Sep 2026 09:31:27 -0700 (PDT)
X-Received: by 2002:a17:90b:3f0d:b0:399:1f8b:d255 with SMTP id
 98e67ed59e1d1-39e10c8a755mr3191111a91.5.1789489886797; 
 Tue, 15 Sep 2026 09:31:26 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39dfdd0baaasm6068590a91.9.2026.09.15.09.31.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 09:31:25 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: sid.manning@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v2 15/17] tests/tcg/hexagon: add rounding conv, sffma:lib,
 and sfinvsqrta
Date: Tue, 15 Sep 2026 09:30:45 -0700
Message-Id: <20260915163047.4180600-16-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260915163047.4180600-1-brian.cain@oss.qualcomm.com>
References: <20260915163047.4180600-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: AIff18gLGnp3doVwR4u6erFSYuYoqGn7
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDI0MCBTYWx0ZWRfX75ZWe2rgbEhf
 88R2ZxNgCHVB0H5YGdh+Z0iIE+fp7xJk0cVIzkmoN/sNLYIlHqKN4k+Tq3ZZWWyKmTo3eOthV8m
 7V73Z6xQDvWjqikMv5Wr6RPIxtHMRVY=
X-Authority-Analysis: v=2.4 cv=dcUVTnXe c=1 sm=1 tr=0 ts=6aa972e0 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=Yw4lSlXxLJphHwZ-g9MA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDI0MCBTYWx0ZWRfX4iZhXxOUaI3o
 p4efysjvtDgusxX2Y+9PtutM6ZDvBvLb1yscLJcSSUxye75uwov9SM3YB8Muh/Vv7Tf1QyHUjee
 VkRLCiu6pLUFpmsAc5VdzxJ1gFiWp3Kv5R9Cwu/mXSsV84BgCgkWzcBbedSS3p5B5k7zZ85e+Bs
 bL/X7O7SUa0mHjoMOYUu3alLvsURKlhN4dP9tvIYi1MkZtLIKtrc5gGCieyDFYFvt917uPY0Ewi
 wkDkVsNyWaLDJdQcKoUECB/yM5forEKOeHCNBVdaFksPCG560+oMEt4/qHwDTnZmQ+Uk771bvjz
 M7j4tpXF7Oziq5vxK/IOlnlwrzCzPgPGvYnTPb8zrK4YoW/6St9PzHmoHWqhvnHqbF6mMxtgHiw
 23vTijmNMvquwbEC6CobqfdlLDHwTLVL9KtwbYNQq1kmwj/Uic5/fV4tkSRdVxx17HJ3G5cWytG
 bpkH4SLaGzrJs3MPISQ==
X-Proofpoint-GUID: AIff18gLGnp3doVwR4u6erFSYuYoqGn7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_04,2026-09-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0
 suspectscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150240
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

QWRkIHJvdW5kLXRvLW5lYXJlc3QgZmxvYXQtdG8taW50IGNvbnZlcnNpb24gdGVzdHMgZm9yIHRo
ZSBub24tOmNob3AgdmFyaWFudHMsCnNmbXB5OmxpYiB3aXRoIEluZi1JbmYgdG8gdmVyaWZ5IGV4
Y2VwdGlvbiBzdXBwcmVzc2lvbiwgYW5kIHNmaW52c3FydGEKd2l0aCBhIGRlbm9ybWFsIGlucHV0
LgoKUmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAb3NzLnF1
YWxjb21tLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVh
bGNvbW0uY29tPgotLS0KIHRlc3RzL3RjZy9oZXhhZ29uL2Zwc3R1ZmYuYyB8IDk5ICsrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA5OSBpbnNlcnRp
b25zKCspCgpkaWZmIC0tZ2l0IGEvdGVzdHMvdGNnL2hleGFnb24vZnBzdHVmZi5jIGIvdGVzdHMv
dGNnL2hleGFnb24vZnBzdHVmZi5jCmluZGV4IDBmMjhhMjE4ZDg0Li45ZWE3OWM2MTdkOSAxMDA2
NDQKLS0tIGEvdGVzdHMvdGNnL2hleGFnb24vZnBzdHVmZi5jCisrKyBiL3Rlc3RzL3RjZy9oZXhh
Z29uL2Zwc3R1ZmYuYwpAQCAtMTAxNyw2ICsxMDE3LDEwMiBAQCBzdGF0aWMgdm9pZCBjaGVja19k
Zm1weWhoKHZvaWQpCiAgICAgY2hlY2s2NF9uZShkZl9leHAocmVzdWx0KSwgMHg3RkYwMDAwMDAw
MDAwMDAwVUxMKTsKIH0KIAorLyoKKyAqIFJvdW5kLXRvLW5lYXJlc3QgZmxvYXQtdG8taW50IGNv
bnZlcnNpb25zIHdpdGggbm9ybWFsIHZhbHVlcy4KKyAqIFRoZXNlIHRlc3QgdGhlIG5vbi06Y2hv
cCB2YXJpYW50cyB3aGljaCB1c2UgdGhlIFVTUiByb3VuZGluZyBtb2RlLgorICovCitzdGF0aWMg
dm9pZCBjaGVja19jb252X3JuZCh2b2lkKQoreworICAgIHVpbnQzMl90IHJlczMyOworICAgIHVp
bnQ2NF90IHJlczY0OworCisgICAgLyogY29udmVydF9zZjJ3KDEuNSkgcm91bmRzIHRvIG5lYXJl
c3QtZXZlbiA9IDIgKi8KKyAgICBhc20oQ0xFQVJfRlBTVEFUVVMKKyAgICAgICAgIiVbcmVzXSA9
IGNvbnZlcnRfc2YydyglW3ZhbF0pXG5cdCIKKyAgICAgICAgOiBbcmVzXSAiPXIiKHJlczMyKQor
ICAgICAgICA6IFt2YWxdICJyIigweDNmYzAwMDAwKSAgICAvKiAxLjVmICovCisgICAgICAgIDog
InIyIiwgInVzciIpOworICAgIGNoZWNrMzIocmVzMzIsIDIpOworCisgICAgLyogY29udmVydF9z
ZjJkKDEuNSkgPSAyICovCisgICAgYXNtKENMRUFSX0ZQU1RBVFVTCisgICAgICAgICIlW3Jlc10g
PSBjb252ZXJ0X3NmMmQoJVt2YWxdKVxuXHQiCisgICAgICAgIDogW3Jlc10gIj1yIihyZXM2NCkK
KyAgICAgICAgOiBbdmFsXSAiciIoMHgzZmMwMDAwMCkgICAgLyogMS41ZiAqLworICAgICAgICA6
ICJyMiIsICJ1c3IiKTsKKyAgICBjaGVjazY0KHJlczY0LCAyVUxMKTsKKworICAgIC8qIGNvbnZl
cnRfZGYydygxLjUpID0gMiAqLworICAgIGFzbShDTEVBUl9GUFNUQVRVUworICAgICAgICAiJVty
ZXNdID0gY29udmVydF9kZjJ3KCVbdmFsXSlcblx0IgorICAgICAgICA6IFtyZXNdICI9ciIocmVz
MzIpCisgICAgICAgIDogW3ZhbF0gInIiKDB4M0ZGODAwMDAwMDAwMDAwMFVMTCkgICAgLyogMS41
ICovCisgICAgICAgIDogInIyIiwgInVzciIpOworICAgIGNoZWNrMzIocmVzMzIsIDIpOworCisg
ICAgLyogY29udmVydF9kZjJkKDEuNSkgPSAyICovCisgICAgYXNtKENMRUFSX0ZQU1RBVFVTCisg
ICAgICAgICIlW3Jlc10gPSBjb252ZXJ0X2RmMmQoJVt2YWxdKVxuXHQiCisgICAgICAgIDogW3Jl
c10gIj1yIihyZXM2NCkKKyAgICAgICAgOiBbdmFsXSAiciIoMHgzRkY4MDAwMDAwMDAwMDAwVUxM
KSAgICAvKiAxLjUgKi8KKyAgICAgICAgOiAicjIiLCAidXNyIik7CisgICAgY2hlY2s2NChyZXM2
NCwgMlVMTCk7Cit9CisKKy8qCisgKiBUZXN0IHNmbXB5OmxpYiB3aXRoIEluZi1JbmYuCisgKgor
ICogUnggKz0gc2ZtcHkoUnMsIFJ0KTpsaWIgd2l0aCBSeCA9IC1JbmYsIFJzKlJ0IC0+ICtJbmYK
KyAqIEluZiAtIEluZiBpcyBpbnZhbGlkLCBidXQgdGhlIDpsaWIgdmFyaWFudCBzdXBwcmVzc2Vz
IHRoZQorICogZXhjZXB0aW9uIGFuZCByZXR1cm5zIHplcm8uCisgKi8KK3N0YXRpYyB2b2lkIGNo
ZWNrX3NmZm1hX2xpYl9pbmYodm9pZCkKK3sKKyAgICB1aW50MzJfdCByZXN1bHQ7CisKKyAgICAv
KiArSW5mICs9IHNmbXB5KCtJbmYsIDEuMCk6bGliIC0+IEluZiAobm8gZXhjZXB0aW9uLCBub3Jt
YWwpICovCisgICAgcmVzdWx0ID0gU0ZfSU5GOworICAgIGFzbShDTEVBUl9GUFNUQVRVUworICAg
ICAgICAiJVtyZXNdICs9IHNmbXB5KCVbYV0sICVbYl0pOmxpYlxuXHQiCisgICAgICAgIDogW3Jl
c10gIityIihyZXN1bHQpCisgICAgICAgIDogW2FdICJyIihTRl9JTkYpLCBbYl0gInIiKFNGX29u
ZSkKKyAgICAgICAgOiAicjIiLCAidXNyIik7CisgICAgY2hlY2szMihyZXN1bHQsIFNGX0lORik7
CisKKyAgICAvKgorICAgICAqIC1JbmYgKz0gc2ZtcHkoK0luZiwgMS4wKTpsaWIgLT4gSW5mIC0g
SW5mID0gaW52YWxpZAorICAgICAqIFRoZSA6bGliIHZhcmlhbnQgc2hvdWxkIHJldHVybiB6ZXJv
IGZvciBJbmYgLSBJbmYuCisgICAgICovCisgICAgcmVzdWx0ID0gU0ZfSU5GIHwgKDF1IDw8IDMx
KTsgICAgLyogLUluZiAqLworICAgIGFzbShDTEVBUl9GUFNUQVRVUworICAgICAgICAiJVtyZXNd
ICs9IHNmbXB5KCVbYV0sICVbYl0pOmxpYlxuXHQiCisgICAgICAgIDogW3Jlc10gIityIihyZXN1
bHQpCisgICAgICAgIDogW2FdICJyIihTRl9JTkYpLCBbYl0gInIiKFNGX29uZSkKKyAgICAgICAg
OiAicjIiLCAidXNyIik7CisgICAgY2hlY2szMihyZXN1bHQsIDApOworfQorCisvKgorICogVGVz
dCBzZmludnNxcnRhIHdpdGggYSBkZW5vcm1hbCBpbnB1dC4KKyAqLworc3RhdGljIHZvaWQgY2hl
Y2tfaW52c3FydGFfZGVub3JtKHZvaWQpCit7CisgICAgdWludDMyX3QgcmVzdWx0OworICAgIHVp
bnQzMl90IHByZWR2YWw7CisgICAgdWludDMyX3QgZXhwX2JpdHM7CisKKyAgICAvKiBEZW5vcm1h
bCBwb3NpdGl2ZSBmbG9hdDogMHgwMDQwMDAwMCAoc21hbGwgZGVub3JtKSAqLworICAgIGFzbSB2
b2xhdGlsZSgiJVtyZXNdLHAwID0gc2ZpbnZzcXJ0YSglW3ZhbF0pXG5cdCIKKyAgICAgICAgICAg
ICAgICAgIiVbcHJlZF0gPSBwMFxuXHQiCisgICAgICAgICAgICAgICAgIDogW3Jlc10gIj1yIihy
ZXN1bHQpLCBbcHJlZF0gIj1yIihwcmVkdmFsKQorICAgICAgICAgICAgICAgICA6IFt2YWxdICJy
IihTRl9kZW5vcm0pCisgICAgICAgICAgICAgICAgIDogInAwIik7CisgICAgLyogUmVzdWx0IHNo
b3VsZCBiZSBhIHZhbGlkIGZsb2F0IChub3QgTmFOL3plcm8pICovCisgICAgY2hlY2szMl9uZShy
ZXN1bHQsIDApOworICAgIGV4cF9iaXRzID0gKHJlc3VsdCA+PiAyMykgJiAweGZmOworICAgIGNo
ZWNrMzJfbmUoZXhwX2JpdHMsIDB4ZmYpOyAgLyogbm90IEluZi9OYU4gKi8KK30KKwogaW50IG1h
aW4oKQogewogICAgIGNoZWNrX2NvbXBhcmVfZXhjZXB0aW9uKCk7CkBAIC0xMDM4LDYgKzExMzQs
OSBAQCBpbnQgbWFpbigpCiAgICAgY2hlY2tfY29udl91ZDJkZigpOwogICAgIGNoZWNrX2RmbXB5
Zml4KCk7CiAgICAgY2hlY2tfZGZtcHloaCgpOworICAgIGNoZWNrX2NvbnZfcm5kKCk7CisgICAg
Y2hlY2tfc2ZmbWFfbGliX2luZigpOworICAgIGNoZWNrX2ludnNxcnRhX2Rlbm9ybSgpOwogCiAg
ICAgcHV0cyhlcnIgPyAiRkFJTCIgOiAiUEFTUyIpOwogICAgIHJldHVybiBlcnIgPyAxIDogMDsK
LS0gCjIuMzQuMQoK

