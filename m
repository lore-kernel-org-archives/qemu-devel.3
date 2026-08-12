Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E20F8C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:44:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuB6y-0004gl-QB; Wed, 12 Aug 2026 11:43:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wuB6d-0004Nx-4Z
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 11:43:08 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wuB6Z-0000HP-Am
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 11:43:01 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CDbTib899536
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 15:42:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=LfqjnCtYCWj/VPU4m6du88tpnDpqXi+E55E4H5hndbI=; b=cR
 a3bRm5NaTQMCcTW81kJMEVxnliyT3bVrZoD950G5PmMj5ms9/IiFoSiUGmIj1BCw
 zY4DIraQfDSMfTgj/2HFH6Eu6RLUPdD8bKV6phSrVTF5uNhA08NbdAyaXO1Cw64a
 KyqZJuw3qhCO0VDRege4JxEwx+gYOVqstwOcSFWSc7RcWUGVZopae4mn2C5+momf
 y0coc7jFqOc2l1tW8nEPwOxeTOTz2aPJUZ5Q8rBxTHYiqFu5zRKVHC2uKQ97IEFe
 MTJ6K3XDdN0nhNDNNDXTCu23kUoD+ZhyTXgSbJZxgkePaNFhZ/99Keo+aQj6EMyJ
 ZKj1VsQgW6IVjyQkafQQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0nut9q7t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 15:42:57 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cbb6433e9d4so1345204a12.3
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 08:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786549377; x=1787154177; darn=nongnu.org;
 h=content-transfer-encoding:content-type:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=LfqjnCtYCWj/VPU4m6du88tpnDpqXi+E55E4H5hndbI=;
 b=DwEAvKKLCuF+9XIbwSQAcqkIllPTujKagD4gk9bqFNdU6WCWTcpzobNIdec4UC0Tfe
 CjtlFU19hCi/qzZ0kofqr5L46/ZKfvyUMt3kVzbh71fAp/VwMuxaGJbx6DCLYiASwCiK
 QCOVbdEReJNqRaLWNtB4GIHl+fuvuR8i2CPqiAYeRk6O3HxN/RHIQ9OHjkhgkBrGd6EW
 ajM2dxfw5p4ifV3Tj8U+HgzwIwV8OsnAbjmQCft0AohKXqUCm2+LJuFBSvGRKhC3Lhl5
 9G/DEFtgTwZa4KbSPQGnWAaBapifuGOi7tFAPUb45Q972qBcGAtTIvhAHFw91y0S4JvB
 mfzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786549377; x=1787154177;
 h=content-transfer-encoding:content-type:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LfqjnCtYCWj/VPU4m6du88tpnDpqXi+E55E4H5hndbI=;
 b=KmU7h5YmaLxzIAjJ411qMmAvk911zCXOmbxLPCU1qTecknFGgzgup7+sr5hldublvs
 mbljSyKGR8jRPktr2LdOAlzIRcjCceG/U1KkdeP183leATo7hLw529+wvcpPDmWYmPfJ
 vLTRgDMD1/I3GQ7DsGgKGpAXmaWcIrH6ONhTT1/fG7nDw3MQQ6pK8P2M4VS6dYhP2MAH
 wqpZMc2JExo3xSS4GryoysYVz3LB15O2uhjnhj/q3walTBjKzXECJZkX9QDxvj+jio62
 zcBv86YBQYfCeOz+7s+EY4MJRLxcqCTR4+OOrsisn3yuD5CB5kTYgBOlxRCBCTMfJp5s
 trqg==
X-Gm-Message-State: AOJu0Yy+A9U3QgqQo4PFXG5ZMAmsPDolhXVCv7DekPw8PuuD1+fGxRGm
 CbNFLdbT+eJrya26W0fiEWbBfzH35d/fBFsK4ZWW/bzR+AC5wnVrta2jfy22wfD7I0fytFVVmPx
 z63LZCTrQyJlv74Loh1Z5FGYJaLu9oGcwkUCsISRlDNwRWrhbNYmka0QrkFad79klTQ==
X-Gm-Gg: AR+sD10ur+EVhODILKnrqkJd4IgbNpRWEnpSNKYqeCiE6Bj1/IZntUpX5Y3566oZB7r
 uOd2m+Ipb9CeBt9DzLDkqe/VhAqaMeizz7THtfaThnBuB+zBAElu3SPNDkodzYu4x8WK3Zp9j/2
 DHPzfzRmzJJS9PZQFQSxh/hIB1ZZlacPfZK8f4wZunHemoa/xrKEaoHhBmIupITo+OOUzeLF7ne
 gFaI+0PtEQBp4NuWL7i7hCY7K8bCQZiDnUFtKCb4csJybgGVRi9gBiq374VP0pQXojbFLAVCnpM
 Ci7eUxyDcf9u1TVTI4kQ+SAEsMxQOc9rw2i7KSscS6bS1umjS8G1paYb4DIqgESONjNl1WnPeG/
 uRYbdTU6WqyZQoiam2prIx3sy00hKAbuPUa4tmyMqVH5Wma6a
X-Received: by 2002:a05:6a21:6e95:b0:3c3:9df8:2eed with SMTP id
 adf61e73a8af0-3cc3f81ed9dmr7467052637.31.1786549377133; 
 Wed, 12 Aug 2026 08:42:57 -0700 (PDT)
X-Received: by 2002:a05:6a21:6e95:b0:3c3:9df8:2eed with SMTP id
 adf61e73a8af0-3cc3f81ed9dmr7466962637.31.1786549376639; 
 Wed, 12 Aug 2026 08:42:56 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31da7bf64b5sm8121190eec.10.2026.08.12.08.42.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 08:42:55 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v2 12/41] hw/hexagon/virt: connect pl011 UART interrupt
Date: Wed, 12 Aug 2026 08:41:51 -0700
Message-Id: <20260812154220.1029828-13-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260812154220.1029828-1-brian.cain@oss.qualcomm.com>
References: <20260812154220.1029828-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEyOCBTYWx0ZWRfX9G96zZeQOJpg
 24bgAEeoiPixQJfWaZPvZE4bAonWlj51zMy8/aXGcp9MX0nea6O7IRFZFQmx2NrtffePZDYjkpo
 quCaF2qZAgAKwj0NbQT7RxXlNGmnFU0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEyOCBTYWx0ZWRfX8racVcKR78Ku
 3tmxXEoOKbMrhfVgmkaVrXsWmglX6wE6T4Qa5uzKtiGyUrxlSeQcSncLS8GGaG/AZhDTcxeEZCr
 T7Ty37zjcHphsYB/lGPyTNJ519q1ba2wVgkvGcEJnOR+0KW6dG2qH6ECwXgW0FEK4MsPgGeRhiu
 7dO7VRVH8hnXS2XDrTBEJYiFZzpX5o1KybqyxGT58xyTboOV0IoGOG/VN3b0d9Uz6BS296m/XVb
 9oNRNTu0gAVrkszSTXBbCii0qeWOEV2pmqFPC5OPzTGSCAGJUvHOK7wm3STUHrvM6EIW/bl5K5w
 fwTS01/kiTomuJYVSepD/z5WPH24e/pAznnswAHLoL8tr9N2FEjCn/4P9tfJaNYeyHi+lJ/rPZM
 4/oOC6f3afKp27pfOMdGKTYsmFF2YJPMQBPy4mcZDudB4y1iitVLYov++a7vhpfWH1gAfLXz/oh
 go9sCOBTcgx+KHUiSag==
X-Proofpoint-ORIG-GUID: vaMggsF5e85L4giU2tJtCRgyKBNdY-Mj
X-Authority-Analysis: v=2.4 cv=POA/P/qC c=1 sm=1 tr=0 ts=6a7c9481 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=AqOQjYCRd4s2zt9NDMsA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: vaMggsF5e85L4giU2tJtCRgyKBNdY-Mj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 adultscore=0
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

V2lyZSBwbDAxMSdzIHN5c2J1cyBJUlEgaW50byBsMnZpYyBhdCBJUlEgMTUuCgpSZXZpZXdlZC1i
eTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBvc3MucXVhbGNvbW0uY29tPgpMaW5r
OiBodHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsLzIwMjYwODA2MDQyNzIzLjM3ODUz
NjktMTMtYnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tClNpZ25lZC1vZmYtYnk6IEJyaWFuIENh
aW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiBody9oZXhhZ29uL3ZpcnQuYyB8
IDEwICsrKysrKysrLS0KIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDIgZGVsZXRp
b25zKC0pCgpkaWZmIC0tZ2l0IGEvaHcvaGV4YWdvbi92aXJ0LmMgYi9ody9oZXhhZ29uL3ZpcnQu
YwppbmRleCBlYTIwZWEzYzUwYS4uNjRkODM2NmQyN2QgMTAwNjQ0Ci0tLSBhL2h3L2hleGFnb24v
dmlydC5jCisrKyBiL2h3L2hleGFnb24vdmlydC5jCkBAIC0zOSw2ICszOSw3IEBAIGVudW0gewog
ICogVklSVElPX0lSUV9CQVNFICsgVklSVElPX0RFVl9DT1VOVCAtIDEKICAqLwogc3RhdGljIGNv
bnN0IGludCBWSVJUSU9fSVJRX0JBU0UgPSAxNjsKK3N0YXRpYyBjb25zdCBpbnQgVklSVF9VQVJU
MF9JUlEgPSAxNTsKIAogc3RhdGljIGNvbnN0IE1lbU1hcEVudHJ5IGJhc2VfbWVtbWFwW10gPSB7
CiAgICAgW1ZJUlRfVUFSVDBdID0geyAweDEwMDAwMDAwLCAweDAwMDAwMjAwIH0sCkBAIC0xNDMs
NyArMTQ0LDcgQEAgc3RhdGljIGludDMyX3QgZmR0X2FkZF9jbG9ja3MoY29uc3QgSGV4YWdvblZp
cnRNYWNoaW5lU3RhdGUgKnZtcykKIH0KIAogc3RhdGljIHZvaWQgZmR0X2FkZF91YXJ0KGNvbnN0
IEhleGFnb25WaXJ0TWFjaGluZVN0YXRlICp2bXMsIGludCB1YXJ0LAotICAgICAgICAgICAgICAg
ICAgICAgICAgIGludDMyX3QgY2xrX3BoYW5kbGUpCisgICAgICAgICAgICAgICAgICAgICAgICAg
aW50MzJfdCBjbGtfcGhhbmRsZSwgaW50MzJfdCBsMnZpY19waGFuZGxlKQogewogICAgIGNoYXIg
Km5vZGVuYW1lOwogICAgIGh3YWRkciBiYXNlID0gYmFzZV9tZW1tYXBbdWFydF0uYmFzZTsKQEAg
LTE2MSw2ICsxNjIsOCBAQCBzdGF0aWMgdm9pZCBmZHRfYWRkX3VhcnQoY29uc3QgSGV4YWdvblZp
cnRNYWNoaW5lU3RhdGUgKnZtcywgaW50IHVhcnQsCiAgICAgcWRldl9jb25uZWN0X2Nsb2NrX2lu
KGRldiwgImNsayIsIHZtcy0+YXBiX2Nsayk7CiAgICAgc3lzYnVzX3JlYWxpemVfYW5kX3VucmVm
KHMsICZlcnJvcl9mYXRhbCk7CiAgICAgc3lzYnVzX21taW9fbWFwKHMsIDAsIGJhc2UpOworICAg
IHN5c2J1c19jb25uZWN0X2lycShzLCAwLAorICAgICAgICAgICAgICAgICAgICAgICBxZGV2X2dl
dF9ncGlvX2luKHZtcy0+cGFyZW50X29iai5sMnZpYywgVklSVF9VQVJUMF9JUlEpKTsKIAogICAg
IG5vZGVuYW1lID0gZ19zdHJkdXBfcHJpbnRmKCIvcGwwMTFAJSIgUFJJeDY0LCBiYXNlKTsKICAg
ICBxZW11X2ZkdF9hZGRfc3Vibm9kZShtcy0+ZmR0LCBub2RlbmFtZSk7CkBAIC0xNjgsNiArMTcx
LDkgQEAgc3RhdGljIHZvaWQgZmR0X2FkZF91YXJ0KGNvbnN0IEhleGFnb25WaXJ0TWFjaGluZVN0
YXRlICp2bXMsIGludCB1YXJ0LAogICAgIC8qIE5vdGUgdGhhdCB3ZSBjYW4ndCB1c2Ugc2V0cHJv
cF9zdHJpbmcgYmVjYXVzZSBvZiB0aGUgZW1iZWRkZWQgTlVMICovCiAgICAgcWVtdV9mZHRfc2V0
cHJvcChtcy0+ZmR0LCBub2RlbmFtZSwgImNvbXBhdGlibGUiLCBjb21wYXQsIHNpemVvZihjb21w
YXQpKTsKICAgICBxZW11X2ZkdF9zZXRwcm9wX2NlbGxzKG1zLT5mZHQsIG5vZGVuYW1lLCAicmVn
IiwgMCwgYmFzZSwgc2l6ZSk7CisgICAgcWVtdV9mZHRfc2V0cHJvcF9jZWxsKG1zLT5mZHQsIG5v
ZGVuYW1lLCAiaW50ZXJydXB0cyIsIFZJUlRfVUFSVDBfSVJRKTsKKyAgICBxZW11X2ZkdF9zZXRw
cm9wX2NlbGwobXMtPmZkdCwgbm9kZW5hbWUsICJpbnRlcnJ1cHQtcGFyZW50IiwKKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgbDJ2aWNfcGhhbmRsZSk7CiAgICAgcWVtdV9mZHRfc2V0cHJvcF9j
ZWxscyhtcy0+ZmR0LCBub2RlbmFtZSwgImNsb2NrcyIsIGNsa19waGFuZGxlLAogICAgICAgICAg
ICAgICAgICAgICAgICAgICAgY2xrX3BoYW5kbGUpOwogICAgIHFlbXVfZmR0X3NldHByb3AobXMt
PmZkdCwgbm9kZW5hbWUsICJjbG9jay1uYW1lcyIsIGNsb2NrbmFtZXMsCkBAIC0zNDIsNyArMzQ4
LDcgQEAgc3RhdGljIHZvaWQgdmlydF9pbml0KE1hY2hpbmVTdGF0ZSAqbXMpCiAKICAgICBmZHRf
YWRkX2NwdV9ub2Rlcyh2bXMpOwogICAgIGNsa19waGFuZGxlID0gZmR0X2FkZF9jbG9ja3Modm1z
KTsKLSAgICBmZHRfYWRkX3VhcnQodm1zLCBWSVJUX1VBUlQwLCBjbGtfcGhhbmRsZSk7CisgICAg
ZmR0X2FkZF91YXJ0KHZtcywgVklSVF9VQVJUMCwgY2xrX3BoYW5kbGUsIGwydmljX3BoYW5kbGUp
OwogCiAgICAgaGV4YWdvbl9sb2FkX2ZkdCh2bXMpOwogfQotLSAKMi4zNC4xCgo=

