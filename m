Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02367606A321
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 05:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fWjopSSn;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hCJ0YEI/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQHY0-00015R-8L; Mon, 09 Nov 2026 00:04:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xQHXe-00013D-I1
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 00:03:39 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xQHXc-0003QE-RA
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 00:03:38 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A93K1GH2936683
 for <qemu-devel@nongnu.org>; Mon, 9 Nov 2026 05:03:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YkW+/b2HyslrComXFGzMYmfOEQgyOhFEMQ523yI0Bac=; b=fWjopSSnyxYyEOjP
 T0+d5DiK1cDVsHavE8eHD8c602F2J0dyWNVv54VXImiCZ5kHfJ5BTxMoF7geI+rk
 0PrGAnSUpefm+T+5eIOwaBZyuYdeY5z7LNJozTPndiiDTsQ3pnoGmfdGJREF5Xz1
 LGvWJUiZciCn+aYtndDVS0lzXWO4AJmLvf86AXwBZnmwE2V+LxgEUQbXtsHOpcf6
 2hl5JrpcS12IjZMmnUnkRiG2oB8FFSu1+ClKS98FeRXNpUlM47jkK5lHa4AvDtSz
 I3MNr4aVdLUgld44sfU3Jb0IY68X+g7jKf2x7Wt9NRZ/TepC9oCLKDmHYsZJcWkX
 VJ67KA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsuagvu9s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 05:03:34 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-36f479b9819so1123813eec.1
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2026 21:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794200613; x=1794805413; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YkW+/b2HyslrComXFGzMYmfOEQgyOhFEMQ523yI0Bac=;
 b=hCJ0YEI/Jta8B0cjOOR23qZ1QCrokKAaZeTkgxHXU4s1RuzKe0OPT1RZvJOrnK3Iu0
 ICFtCYJ4tsyJNqt3hLqqD7+En6c7BBBOagKgTX5BN2RxXWZLU9jOHFze3k5AfBKUiNmV
 T6ti62TFodkvc6sKcyuY0/37/evfUac1o/8nUnZJzghTVXEjYotkS5dlI+xosLVw9qf8
 BcRi00dCbBMGEXUZL5FFu6BFLSaene8uL7WcrLtiLLxDBwcituT3iol9+NQFAo9VrJnV
 ZKR01qnFkznUSKyhHhD/o9h6Tv3Do+22hcjeWR63wpzdxLz35stf8Jkp9eKObGwZ/i7Z
 gJdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794200613; x=1794805413;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YkW+/b2HyslrComXFGzMYmfOEQgyOhFEMQ523yI0Bac=;
 b=OaU74I2ULQAEhS9MkreLShoBMS3OXJZ5zUrHaMxAvdgTJ3F74hoZTU6G240XgKFIU/
 13oMT8LWPDDirxcxs9Yc5l3QYu3eHdym5qaSdH/BxyRcrr5hSgfY67gypZZskhhQIRBh
 beBmgWeNssz328QqJHApS2hfLmBm821rzcwXkkfhnA2Pt85SciFE1vlLQwtj3vLPPGzk
 L+88CgnOd84o8Ta2dzbPPFcBhY/SZVZLLjGCauNFhtP/XJ9ggRG6CrQCutTPlIyNaL+x
 guJJ/ik3103Mn0H0Jv/MkWhDI9NGuNv0V4R49r9wI98MQPMPVxXwueptFWiJO+cNgFJi
 OL6g==
X-Gm-Message-State: APuU4Z8meFDvClm0xMRDhNMa4+Fduq9+3uR3ys06lSmwmnVoVXawqaqE
 2Q6nj2p4dYizJ8nowltOjZdSI3d5+M5YZFWu72/tYnUSSOyU0fvNwV67mXlTSBimJ6/hN/YFLFv
 iJjPjnXNiScaifFZi7GxzSyZ5H+4J95Mi4Y8cB8CWF9Z2CdR8AwFEiEGWC3hI4EmI5w==
X-Gm-Gg: AYBFou1HlbRyVreIp29rl+O+lOZhgstyMCMpao/RpcmBI+R/MHLWfHtYuRA0JIBc73t
 WGRF/wCLmILH2Z4AelWl+nz2w0jARC7mUyMpTBaGb83cWioHYEXQ450Ovo7dnbYxdZBlO3vVzUn
 dT9QK7r7i+ptO1u0p6lBty7FOMcN9FAuhPABfWUqBkR4pL35DCdS0MACfKsDkhpiMvgXZE2nFOM
 ux2yl8jGEs7rVsPh/FFoMj8xNEMpz6Nq4HApbgPa6Gya6o/5qAbyugfHfmqfZkyyxv0yuYiSDlG
 O0wf+qQrxSViORIOTaIYiEle05PCWjHzVIECJOPw9E2qurNGEjXzHBwa1texN+GlNBaHK6DbiZY
 RU7Vke7LmMXqOY7sf178x7ZV+yO0DamBD9wi3uQf7y7u08NrOCeaujqXAJX58HYOu6w6QMmhHNx
 TGs0Zeu1nPFbRktwry2meiBw==
X-Received: by 2002:a05:7300:ea83:b0:36e:b05e:9a74 with SMTP id
 5a478bee46e88-37255e48257mr4991268eec.30.1794200613250; 
 Sun, 08 Nov 2026 21:03:33 -0800 (PST)
X-Received: by 2002:a05:7300:ea83:b0:36e:b05e:9a74 with SMTP id
 5a478bee46e88-37255e48257mr4991236eec.30.1794200612640; 
 Sun, 08 Nov 2026 21:03:32 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37265c0701csm10119520eec.13.2026.11.08.21.03.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2026 21:03:32 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH 3/3] hw/hexagon: fix FDT address and size cells
Date: Sun,  8 Nov 2026 21:03:27 -0800
Message-Id: <20261109050327.1475448-4-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261109050327.1475448-1-brian.cain@oss.qualcomm.com>
References: <20261109050327.1475448-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAxOSBTYWx0ZWRfX0Bfb9QSsaYV1
 G4YbjCVKf4kmSMzzUFCeSG7qmSG5kC7dXhev8BJMxSGkCQduQFsyngVhn1Vk2SjjiXAbLU6wdpH
 6lZ8ht8Yx9K1iPdt9DpRN3Yi4ZIt8opaLJ/MKbkMfrnfNsSbLekg3NLFqw1s1DrAy/kDXTAD9eL
 xYQUEjktq+4uRyuFZ1vbMD9cI9oWlo1md/YDjOJ1bBJcbNyJqA2APF5SvZgnfJODfDdanwPkTb3
 UdRO/VxBImdd5BKqyN7Xnu3G4W8nJNe6sAMJ9SmolhoSPEHLBDyW/qjZvTf7/iCgu3oA1d2C+GA
 pPcXMXkzuV43rfp28zjx6oTrRP9DfJA70C1gqkYGXHtHg0nWENNQUdS+6oxf7tnJfIXvob+Bq09
 F3MNH5Xe4p4AacSa1LNEpAzyP3JIeY8jITiWwdM84+AmZNrKWyYp5Krc1+CJ9B6w9xHSJl9ROid
 8wReCov2rzZRhQTTgpQ==
X-Proofpoint-ORIG-GUID: o-bbHhKcl-bbVE8QLsZxhJAmD5JBcXCL
X-Proofpoint-GUID: o-bbHhKcl-bbVE8QLsZxhJAmD5JBcXCL
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDAxOSBTYWx0ZWRfX4Ow/aVnrM3qn
 XfIROhDBC/wNjZexZiEvzsb+iBmsuXsv0TasUpdFiKz+ISHK3NwltlTo7x/kwSwCzgZ5rFWh85f
 T7bh8qyJwKW18pYLcSIA0ZrCBaiZ+4E=
X-Authority-Analysis: v=2.4 cv=V8LoQuni c=1 sm=1 tr=0 ts=6af15426 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=3RaGgONpw-BU2ZlCsxAA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 malwarescore=0 bulkscore=0 impostorscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090019
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SGV4YWdvbiBNTVVzIHN1cHBvcnQgNjQtYml0IHBoeXNpY2FsIGFkZHJlc3Nlcy4gIERlc2NyaWJl
IHRoZSByb290IGFuZAovc29jIGJ1c2VzIHdpdGggdHdvIGFkZHJlc3MgY2VsbHMgYW5kIHR3byBz
aXplIGNlbGxzIHNvIHRoZWlyIGNoaWxkIHJlZwpwcm9wZXJ0aWVzIGNhbiByZXByZXNlbnQgdGhl
IGZ1bGwgYWRkcmVzcyBhbmQgc2l6ZSByYW5nZS4KClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4g
PGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiBody9oZXhhZ29uL2hleC1ib2FyZC5j
IHwgMTMgKysrKysrKy0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgNiBk
ZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9ody9oZXhhZ29uL2hleC1ib2FyZC5jIGIvaHcvaGV4
YWdvbi9oZXgtYm9hcmQuYwppbmRleCBjM2I4YzY0N2U0ZC4uZjJkOGI3NmY2YzMgMTAwNjQ0Ci0t
LSBhL2h3L2hleGFnb24vaGV4LWJvYXJkLmMKKysrIGIvaHcvaGV4YWdvbi9oZXgtYm9hcmQuYwpA
QCAtNDMsMTMgKzQzLDEzIEBAIHZvaWQgaGV4X2JvYXJkX2NyZWF0ZV9mZHQoTWFjaGluZVN0YXRl
ICptcywgY29uc3QgY2hhciAqbW9kZWwsCiAgICAgbXMtPmZkdCA9IGZkdDsKIAogICAgIHFlbXVf
ZmR0X3NldHByb3BfY2VsbChmZHQsICIvIiwgIiNhZGRyZXNzLWNlbGxzIiwgMHgyKTsKLSAgICBx
ZW11X2ZkdF9zZXRwcm9wX2NlbGwoZmR0LCAiLyIsICIjc2l6ZS1jZWxscyIsIDB4MSk7CisgICAg
cWVtdV9mZHRfc2V0cHJvcF9jZWxsKGZkdCwgIi8iLCAiI3NpemUtY2VsbHMiLCAweDIpOwogICAg
IHFlbXVfZmR0X3NldHByb3Bfc3RyaW5nKGZkdCwgIi8iLCAibW9kZWwiLCBtb2RlbCk7CiAgICAg
cWVtdV9mZHRfc2V0cHJvcF9zdHJpbmcoZmR0LCAiLyIsICJjb21wYXRpYmxlIiwgY29tcGF0aWJs
ZSk7CiAKICAgICBxZW11X2ZkdF9hZGRfc3Vibm9kZShmZHQsICIvc29jIik7CiAgICAgcWVtdV9m
ZHRfc2V0cHJvcF9jZWxsKGZkdCwgIi9zb2MiLCAiI2FkZHJlc3MtY2VsbHMiLCAweDIpOwotICAg
IHFlbXVfZmR0X3NldHByb3BfY2VsbChmZHQsICIvc29jIiwgIiNzaXplLWNlbGxzIiwgMHgxKTsK
KyAgICBxZW11X2ZkdF9zZXRwcm9wX2NlbGwoZmR0LCAiL3NvYyIsICIjc2l6ZS1jZWxscyIsIDB4
Mik7CiAgICAgcWVtdV9mZHRfc2V0cHJvcChmZHQsICIvc29jIiwgInJhbmdlcyIsIE5VTEwsIDAp
OwogCiAgICAgcWVtdV9mZHRfYWRkX3N1Ym5vZGUoZmR0LCAiL2Nob3NlbiIpOwpAQCAtNzgsNyAr
NzgsNyBAQCBpbnQzMl90IGhleF9ib2FyZF9mZHRfYWRkX2wydmljKE1hY2hpbmVTdGF0ZSAqbXMs
CiAgICAgcWVtdV9mZHRfc2V0cHJvcF9jZWxsKG1zLT5mZHQsIG5vZGVuYW1lLCAiI2ludGVycnVw
dC1jZWxscyIsIDIpOwogICAgIHFlbXVfZmR0X3NldHByb3AobXMtPmZkdCwgbm9kZW5hbWUsICJj
b21wYXRpYmxlIiwgY29tcGF0LCBzaXplb2YoY29tcGF0KSk7CiAgICAgcWVtdV9mZHRfc2V0cHJv
cF9jZWxscyhtcy0+ZmR0LCBub2RlbmFtZSwgInJlZyIsIDAsIGNmZy0+bDJ2aWNfYmFzZSwKLSAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGNmZy0+bDJ2aWNfc2l6ZSk7CisgICAgICAgICAgICAg
ICAgICAgICAgICAgICAwLCBjZmctPmwydmljX3NpemUpOwogICAgIHFlbXVfZmR0X3NldHByb3Ao
bXMtPmZkdCwgbm9kZW5hbWUsICJpbnRlcnJ1cHQtY29udHJvbGxlciIsIE5VTEwsIDApOwogICAg
IHFlbXVfZmR0X3NldHByb3BfY2VsbChtcy0+ZmR0LCBub2RlbmFtZSwgInBoYW5kbGUiLCBsMnZp
Y19waGFuZGxlKTsKIApAQCAtOTUsNyArOTUsOCBAQCB2b2lkIGhleF9ib2FyZF9mZHRfYWRkX2h2
eChNYWNoaW5lU3RhdGUgKm1zLAogICAgICAgICBxZW11X2ZkdF9zZXRwcm9wX3N0cmluZyhtcy0+
ZmR0LCAiL3NvYy92dGNtIiwgImNvbXBhdGlibGUiLAogICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAicWNvbSxoZXhhZ29uX3Z0Y20iKTsKICAgICAgICAgcWVtdV9mZHRfc2V0cHJvcF9j
ZWxscyhtcy0+ZmR0LCAiL3NvYy92dGNtIiwgInJlZyIsIDAsCi0gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgdC0+dnRjbV9iYXNlIDw8IDE2LCB0LT52dGNtX3NpemVfa2IgKiAxMDI0KTsK
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0LT52dGNtX2Jhc2UgPDwgMTYsIDAsCisg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdC0+dnRjbV9zaXplX2tiICogMTAyNCk7CiAg
ICAgfQogCiAgICAgaWYgKHQtPmV4dF9jb250ZXh0cyA+IDApIHsKQEAgLTE3NSw3ICsxNzYsNyBA
QCB2b2lkIGhleF9ib2FyZF9jcmVhdGVfdWFydChNYWNoaW5lU3RhdGUgKm1zLCBod2FkZHIgYmFz
ZSwgaHdhZGRyIHNpemUsCiAgICAgcWVtdV9mZHRfYWRkX3N1Ym5vZGUobXMtPmZkdCwgbm9kZW5h
bWUpOwogICAgIC8qIENhbid0IHVzZSBzZXRwcm9wX3N0cmluZyBiZWNhdXNlIG9mIHRoZSBlbWJl
ZGRlZCBOVUwgKi8KICAgICBxZW11X2ZkdF9zZXRwcm9wKG1zLT5mZHQsIG5vZGVuYW1lLCAiY29t
cGF0aWJsZSIsIGNvbXBhdCwgc2l6ZW9mKGNvbXBhdCkpOwotICAgIHFlbXVfZmR0X3NldHByb3Bf
Y2VsbHMobXMtPmZkdCwgbm9kZW5hbWUsICJyZWciLCAwLCBiYXNlLCBzaXplKTsKKyAgICBxZW11
X2ZkdF9zZXRwcm9wX2NlbGxzKG1zLT5mZHQsIG5vZGVuYW1lLCAicmVnIiwgMCwgYmFzZSwgMCwg
c2l6ZSk7CiAgICAgZmR0X3NldF9pcnEobXMsIG5vZGVuYW1lLCBpcnEpOwogICAgIHFlbXVfZmR0
X3NldHByb3BfY2VsbChtcy0+ZmR0LCBub2RlbmFtZSwgImludGVycnVwdC1wYXJlbnQiLAogICAg
ICAgICAgICAgICAgICAgICAgICAgICBsMnZpY19waGFuZGxlKTsKQEAgLTIxMSw3ICsyMTIsNyBA
QCB2b2lkIGhleF9ib2FyZF9jcmVhdGVfdmlydGlvKE1hY2hpbmVTdGF0ZSAqbXMsIGh3YWRkciBi
YXNlLCBod2FkZHIgc2l6ZSwKICAgICAgICAgcWVtdV9mZHRfYWRkX3N1Ym5vZGUobXMtPmZkdCwg
bm9kZW5hbWUpOwogICAgICAgICBxZW11X2ZkdF9zZXRwcm9wX3N0cmluZyhtcy0+ZmR0LCBub2Rl
bmFtZSwgImNvbXBhdGlibGUiLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAidmly
dGlvLG1taW8iKTsKLSAgICAgICAgcWVtdV9mZHRfc2V0cHJvcF9jZWxscyhtcy0+ZmR0LCBub2Rl
bmFtZSwgInJlZyIsIDAsIHNsb3QsIHNpemUpOworICAgICAgICBxZW11X2ZkdF9zZXRwcm9wX2Nl
bGxzKG1zLT5mZHQsIG5vZGVuYW1lLCAicmVnIiwgMCwgc2xvdCwgMCwgc2l6ZSk7CiAgICAgICAg
IGZkdF9zZXRfaXJxKG1zLCBub2RlbmFtZSwgaXJxKTsKICAgICAgICAgcWVtdV9mZHRfc2V0cHJv
cF9jZWxsKG1zLT5mZHQsIG5vZGVuYW1lLCAiaW50ZXJydXB0LXBhcmVudCIsCiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBsMnZpY19waGFuZGxlKTsKLS0gCjIuMzQuMQoK

