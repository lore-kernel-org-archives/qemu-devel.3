Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA158C98318
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 01:55:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9v9X-00050a-0R; Thu, 24 Sep 2026 21:55:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x9v9P-0004xv-Gz
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 21:54:59 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x9v9N-0005tT-RA
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 21:54:59 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68P1lOBO3885763
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 01:54:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 IcJNdY4hlB5wuvciSxp0uXAgBsXsEcVgYAWPzivXFtc=; b=j66iVcqjkSZhRyon
 1e1K2EHUdex3/SmHnVn/jZ26ukfiMnMZuW+C3x4x880IFnMjPJWbHJkh8tYCxNnV
 8A6pHrhOwBKJz8Y0YrkofC4hlcqk64zG/Zm20L7Iur8a5SCF2ZrRbS9Wm+IPRxjP
 kzMpyBPJUEjiyeO5rIRgAOcpCb4e1zj2W/I3M3GDwvom42lTNDH9hn7Na719E/fy
 ayhCsRrnSyTZM7Km7y8M3IJ4F1RO5ikoLrjtdxiAwkX0JAuOcW0qsQGNTuBlzlPk
 jL6v61ncZDp/8a6jT2GH3c1TkOlhjjRTlBrezgvXhUzU3T3+CaJVUPN1jvqi2KC2
 VJVF4g==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw4652s20-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 01:54:56 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-33310847fcaso651445eec.1
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 18:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790301296; x=1790906096; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=IcJNdY4hlB5wuvciSxp0uXAgBsXsEcVgYAWPzivXFtc=;
 b=EyPfAk6c3qQk7I2o4zQJxcw2p9An3GzP9ojxQ8PNbg9P8sJ0OVe+CMg3xaj547iVoD
 J84CngGFReZDdQR8IkRWNa0HwQlZZlT+4Y2ih+1ALPep/dK4x7bHVpPB1Scvwo+iH+uy
 xYsWVRNMU1+EKUsth6Ui1GEgXRqhIjYKYkOlBYpU8XTWntSUwMTogQHaKvIidmZmFent
 OzPYxCXYrvxQeaHh3uk5qom0mme5bxqCEwMPbDe1HGsOZv8+A8EL0P4oNeXO3E1e7tkX
 K7h0Ic5NkDtaZfp5r0cjhq96t1BckTj52vEnOjyz85zEVoP+sfhIjawGrP18oCzH68Cf
 C+sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790301296; x=1790906096;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IcJNdY4hlB5wuvciSxp0uXAgBsXsEcVgYAWPzivXFtc=;
 b=kElevKkWReztARLRjRlvQ6M5UX/P/pWo3yiPzj9EpTS9n9AdNTh9cYVTp6ZRGf1byw
 lqoM9dosVtAHSux73EhfKRY7VM2j1N71c3U6NGC5hS/NgE3MHzPjQVTaGRkV1Zo/Uhvf
 nZXX/rIHsz12mer1t8e8jN6Ctb3wxtSPeHC34tmfnHwFs+sxplbWp8gmJYnNpIAJo3um
 u9Lv4jhGhtZuab+kdYMfYAsidU2ubpGLWWot6JWsAGFTZQbaQcuEbmSnjThwiUf7B4mb
 g4fkfLGfKZLu/6pt/G/ieOL+3ALTQrikKW6vag2xroNP49yNkkuBuklDZO91chpG4n0g
 xnsw==
X-Gm-Message-State: AFuF++nYxeWPY8WsqFBqXTORC5GJj2iuqxa+IlCU0xxxWLrtIgRvl2L/
 /+wEbsIgwHgP5LqxEW3keIVA4gdvr61/ir3Q7LPaJhl/jlo8NFfRu3XlTaKO04a9WQaqT4VgXXY
 MQgCmjkQMejQ5SNsI6DeuACAsIMRrcXmuiM9bCVxrbJ/aGo4DTV/uTAXyoGRYTgTmfw==
X-Gm-Gg: AYBFou3i+7uWdj14WmSlvABgUvRj22qhv0OnwMWVjBIFH0jS6dnX8nVtoMjI422XRZR
 IWfMkereUnkXxOOZ17kqiv3jv46ThO3eyVzAfKzGpYtH2y+q/f/VriFWOVaXOwBAKbxP3WUqXxb
 Yn5NmYiTdPm74PX6RZmzbg44Ii1nhWaIvPSytCT7IFzDA2jaoJ7IY6eEDmATk3cMkIpjFXaXt4S
 DAijKd/eqkzLyHXueXlYJiXsFDlEhQwx3+mB5vK6mmCoW2Gs7rAyJeN8FcIflrrEAgYQ/GhbqnK
 ZPHO5AgeaRBsvw7hHnc3DFHS45UaLrAj890ouEmmVJw8S2fV7dgoyOBgl6+E+Cld/1Rk7gGL7Bu
 QbsCQhrlm0oZwOx1fI5nIXixBWz/DO45oFY2oP+915g35WsI=
X-Received: by 2002:a05:7301:1a15:b0:33b:bea7:84dd with SMTP id
 5a478bee46e88-3419a205e1bmr312735eec.34.1790301295461; 
 Thu, 24 Sep 2026 18:54:55 -0700 (PDT)
X-Received: by 2002:a05:7301:1a15:b0:33b:bea7:84dd with SMTP id
 5a478bee46e88-3419a205e1bmr312721eec.34.1790301294765; 
 Thu, 24 Sep 2026 18:54:54 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3416e4c2f50sm1873720eec.27.2026.09.24.18.54.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 18:54:53 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Sid Manning <sid.manning@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 13/40] tests/tcg/hexagon: fix undefined signed integer overflow
 in hvx_misc
Date: Thu, 24 Sep 2026 18:54:02 -0700
Message-Id: <20260925015429.2579174-14-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260925015429.2579174-1-brian.cain@oss.qualcomm.com>
References: <20260925015429.2579174-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=Wrq+otfv c=1 sm=1 tr=0 ts=6ab5d470 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=7jozP2JQLfe_envvOV8A:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: 4rF_xTg6i1926KU6J-L1F48mSIej8sCx
X-Proofpoint-GUID: 4rF_xTg6i1926KU6J-L1F48mSIej8sCx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAwNyBTYWx0ZWRfX4pKyevOJ9Wdh
 hrH+gGQwU00YhLZEaCdeW5UayYWgM/wi9eBVdFioaE6FsDiA0KW4bV31C9GoY0mOezHMNKuWwcc
 8fAJGgSfwjWI/LAeLtgGjlp6NsNw+gtQTKb+p0QN1zG/hDaKC4X4aWwIDuHdpumsV2ngq2LJu5A
 QdzgI4Ph6nlLZZ7Fj6hhCEA/G/20oOi553oskc9zhCAM7zWcV212Qyizue/XHVKBtgnzlO8qtID
 BpYouGlw0AfSSwwPjC6zXPaMBdTQLWhEvQDJQhh7+x5tm/UkWSSEiR1u41CfR+SB4+83xdHckG8
 F2LbBNCy84AuCszBMKCysZRuNTuNJ8IAfcijS8lNPTF6e5IQDefU1ojm8W5EO6NFbH8crK+J8/t
 B24MQCIHBsRdMhaDTnAyCJXPSmKazDkvtfofCZlhTZRLoj5hz3zHBmbOczCJTU0LUMUqRrERzQ4
 FKCI8BtZI7k+4p+av0A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAwNyBTYWx0ZWRfXzSsI6Osm27nx
 bwiNKpbM322yOLwo1Wt24fu1zt4ZDdlQVRRINlshX7UmVDsxRigwv3utaJMK14f1yUlZF+7NsCJ
 n/9Cllk8N/GLd39Q8hjhqhjrc6ZeHS4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250007
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

VXNlIHVuc2lnbmVkICgudXcpIGluc3RlYWQgb2Ygc2lnbmVkICgudykgYXJyYXkgbWVtYmVycyBm
b3IKdmVjdG9yIGFkZGl0aW9uIGFuZCBzdWJ0cmFjdGlvbiByZWZlcmVuY2UgY2FsY3VsYXRpb25z
IHRvIGF2b2lkCnNpZ25lZCBpbnRlZ2VyIG92ZXJmbG93LiBXcmFwcGluZyBhcml0aG1ldGljIGlz
IHdlbGwtZGVmaW5lZCBmb3IKdW5zaWduZWQgdHlwZXMuIEFkZCBDSEVDS19PVVRQVVRfRlVOQyh1
dywgNCkgdG8gc3VwcG9ydCB1bnNpZ25lZAp3b3JkIGNvbXBhcmlzb25zIGluIHRoZSBURVNUX1ZF
Q19PUDIgbWFjcm8uCkZvdW5kIHdpdGggVUJTYW4uCgpSZXZpZXdlZC1ieTogU2lkIE1hbm5pbmcg
PHNpZC5tYW5uaW5nQG9zcy5xdWFsY29tbS5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4g
PGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0ZXN0cy90Y2cvaGV4YWdvbi9odnhf
bWlzYy5oIHwgIDEgKwogdGVzdHMvdGNnL2hleGFnb24vaHZ4X21pc2MuYyB8IDE4ICsrKysrKysr
Ky0tLS0tLS0tLQogMiBmaWxlcyBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9u
cygtKQoKZGlmZiAtLWdpdCBhL3Rlc3RzL3RjZy9oZXhhZ29uL2h2eF9taXNjLmggYi90ZXN0cy90
Y2cvaGV4YWdvbi9odnhfbWlzYy5oCmluZGV4IGMyMWVhOTc1YzE2Li5lMzI3MTVlZDExZCAxMDA2
NDQKLS0tIGEvdGVzdHMvdGNnL2hleGFnb24vaHZ4X21pc2MuaAorKysgYi90ZXN0cy90Y2cvaGV4
YWdvbi9odnhfbWlzYy5oCkBAIC02OSw2ICs2OSw3IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBjaGVj
a19vdXRwdXRfIyNGSUVMRChpbnQgbGluZSwgc2l6ZV90IG51bV92ZWN0b3JzKSBcCiBDSEVDS19P
VVRQVVRfRlVOQyhkLCAgOCkKIENIRUNLX09VVFBVVF9GVU5DKHcsICA0KQogQ0hFQ0tfT1VUUFVU
X0ZVTkMoc2YsIDQpCitDSEVDS19PVVRQVVRfRlVOQyh1dywgNCkKIENIRUNLX09VVFBVVF9GVU5D
KGgsICAyKQogQ0hFQ0tfT1VUUFVUX0ZVTkModWgsIDIpCiBDSEVDS19PVVRQVVRfRlVOQyhoZiwg
MikKZGlmZiAtLWdpdCBhL3Rlc3RzL3RjZy9oZXhhZ29uL2h2eF9taXNjLmMgYi90ZXN0cy90Y2cv
aGV4YWdvbi9odnhfbWlzYy5jCmluZGV4IDMyYTM2NjFhODZmLi5mMjBhZmM4ZTY3MCAxMDA2NDQK
LS0tIGEvdGVzdHMvdGNnL2hleGFnb24vaHZ4X21pc2MuYworKysgYi90ZXN0cy90Y2cvaGV4YWdv
bi9odnhfbWlzYy5jCkBAIC01NSw3ICs1NSw3IEBAIHN0YXRpYyB2b2lkIHRlc3RfbG9hZF90bXAo
dm9pZCkKICAgICAgICAgcG91dCArPSBzaXplb2YoTU1WZWN0b3IpOwogCiAgICAgICAgIGZvciAo
aW50IGogPSAwOyBqIDwgTUFYX1ZFQ19TSVpFX0JZVEVTIC8gNDsgaisrKSB7Ci0gICAgICAgICAg
ICBleHBlY3RbaV0ud1tqXSA9IGJ1ZmZlcjBbaV0ud1tqXSArIGJ1ZmZlcjFbaV0ud1tqXSArIDE7
CisgICAgICAgICAgICBleHBlY3RbaV0udXdbal0gPSBidWZmZXIwW2ldLnV3W2pdICsgYnVmZmVy
MVtpXS51d1tqXSArIDE7CiAgICAgICAgIH0KICAgICB9CiAKQEAgLTI4NSw4ICsyODUsOCBAQCBz
dGF0aWMgdm9pZCB0ZXN0X21heF90ZW1wcygpCiAKICAgICAgICAgLyogVGhlIGZpcnN0IHR3byB2
ZWN0b3JzIGNvbWUgZnJvbSB0aGUgdmFkZC1wYWlyIGluc3RydWN0aW9uICovCiAgICAgICAgIGZv
ciAoaW50IGkgPSAwOyBpIDwgTUFYX1ZFQ19TSVpFX0JZVEVTIC8gNDsgaSsrKSB7Ci0gICAgICAg
ICAgICBleHBlY3RbMF0ud1tpXSA9IGJ1ZmZlcjBbMF0ud1tpXSArIGJ1ZmZlcjBbMl0ud1tpXTsK
LSAgICAgICAgICAgIGV4cGVjdFsxXS53W2ldID0gYnVmZmVyMFsxXS53W2ldICsgYnVmZmVyMFsz
XS53W2ldOworICAgICAgICAgICAgZXhwZWN0WzBdLnV3W2ldID0gYnVmZmVyMFswXS51d1tpXSAr
IGJ1ZmZlcjBbMl0udXdbaV07CisgICAgICAgICAgICBleHBlY3RbMV0udXdbaV0gPSBidWZmZXIw
WzFdLnV3W2ldICsgYnVmZmVyMFszXS51d1tpXTsKICAgICAgICAgfQogICAgICAgICAvKiBUaGUg
dGhpcmQgdmVjdG9yIGNvbWVzIGZyb20gdGhlIHZzaHVmZmUgaW5zdHJ1Y3Rpb24gKi8KICAgICAg
ICAgZm9yIChpbnQgaSA9IDA7IGkgPCBNQVhfVkVDX1NJWkVfQllURVMgLyAyOyBpKyspIHsKQEAg
LTI5NSw3ICsyOTUsNyBAQCBzdGF0aWMgdm9pZCB0ZXN0X21heF90ZW1wcygpCiAgICAgICAgIH0K
ICAgICAgICAgLyogVGhlIGZvdXJ0aCB2ZWN0b3IgY29tZXMgZnJvbSB0aGUgdmFkZC1zaW5nbGUg
aW5zdHJ1Y3Rpb24gKi8KICAgICAgICAgZm9yIChpbnQgaSA9IDA7IGkgPCBNQVhfVkVDX1NJWkVf
QllURVMgLyA0OyBpKyspIHsKLSAgICAgICAgICAgIGV4cGVjdFszXS53W2ldID0gYnVmZmVyMFsx
XS53W2ldICsgYnVmZmVyMFs1XS53W2ldOworICAgICAgICAgICAgZXhwZWN0WzNdLnV3W2ldID0g
YnVmZmVyMFsxXS51d1tpXSArIGJ1ZmZlcjBbNV0udXdbaV07CiAgICAgICAgIH0KICAgICAgICAg
LyoKICAgICAgICAgICogVGhlIGZpZnRoIHZlY3RvciBjb21lcyBmcm9tIHRoZSBsb2FkIHRvIHY0
CkBAIC0zMDYsMTAgKzMwNiwxMCBAQCBzdGF0aWMgdm9pZCB0ZXN0X21heF90ZW1wcygpCiAgICAg
ICAgIGNoZWNrX291dHB1dF9iKF9fTElORV9fLCA1KTsKIH0KIAotVEVTVF9WRUNfT1AyKHZhZGRf
dywgdmFkZCwgLncsIHcsIDQsICspCitURVNUX1ZFQ19PUDIodmFkZF93LCB2YWRkLCAudywgdXcs
IDQsICspCiBURVNUX1ZFQ19PUDIodmFkZF9oLCB2YWRkLCAuaCwgaCwgMiwgKykKIFRFU1RfVkVD
X09QMih2YWRkX2IsIHZhZGQsIC5iLCBiLCAxLCArKQotVEVTVF9WRUNfT1AyKHZzdWJfdywgdnN1
YiwgLncsIHcsIDQsIC0pCitURVNUX1ZFQ19PUDIodnN1Yl93LCB2c3ViLCAudywgdXcsIDQsIC0p
CiBURVNUX1ZFQ19PUDIodnN1Yl9oLCB2c3ViLCAuaCwgaCwgMiwgLSkKIFRFU1RfVkVDX09QMih2
c3ViX2IsIHZzdWIsIC5iLCBiLCAxLCAtKQogVEVTVF9WRUNfT1AyKHZ4b3IsIHZ4b3IsICwgZCwg
OCwgXikKQEAgLTQ4OSw5ICs0ODksOSBAQCBzdGF0aWMgdm9pZCB0ZXN0X2xvYWRfdG1wX3ByZWRp
Y2F0ZWQodm9pZCkKICAgICAgICAgcG91dCArPSBzaXplb2YoTU1WZWN0b3IpOwogCiAgICAgICAg
IGZvciAoaW50IGogPSAwOyBqIDwgTUFYX1ZFQ19TSVpFX0JZVEVTIC8gNDsgaisrKSB7Ci0gICAg
ICAgICAgICBleHBlY3RbaV0ud1tqXSA9Ci0gICAgICAgICAgICAgICAgcHJlZCA/IGJ1ZmZlcjBb
aV0ud1tqXSArIGJ1ZmZlcjFbaV0ud1tqXSArIDEKLSAgICAgICAgICAgICAgICAgICAgIDogYnVm
ZmVyMFtpXS53W2pdICsgMjsKKyAgICAgICAgICAgIGV4cGVjdFtpXS51d1tqXSA9CisgICAgICAg
ICAgICAgICAgcHJlZCA/IGJ1ZmZlcjBbaV0udXdbal0gKyBidWZmZXIxW2ldLnV3W2pdICsgMQor
ICAgICAgICAgICAgICAgICAgICAgOiBidWZmZXIwW2ldLnV3W2pdICsgMjsKICAgICAgICAgfQog
ICAgICAgICBwcmVkID0gIXByZWQ7CiAgICAgfQotLSAKMi4zNC4xCgo=

