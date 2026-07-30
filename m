Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FFB5C53200
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 01:30:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpFZn-0005iW-VJ; Wed, 29 Jul 2026 21:28:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wpFZm-0005i4-QZ
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 21:28:46 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wpFZl-0005bI-9C
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 21:28:46 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66U1GhUU3699494
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 01:28:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=z+6qeAlJOKKWo1FncvQKP0fGn79PFWfQcGh4oQBRHxU=; b=Vq
 qVqAeyzAuuB8CgWG/eYlLsRgWg0k/1SOAfGL8uG0AFMXA7+lQGuBq1OUwqVU2yMV
 hMRw2HxW2OXUa0r751HOFk1EypfbvOim37uv12pI+QbIs6m8p59g9RxqM9K75rdo
 johcmKPHkiCOWTaP36jf34xtoDR3Yi/aDmSELjwCHKTcHnhCi1A0flqM33+1jTKh
 YxTWvNDH7HDKbYfZhQ2NUDnaWB14oiE3HkwIYC2/iIM5ZydTEsYE15/SaVemjluP
 YBKzF4RQ2XGnXabiZfmgk9xZJ2rNTYs5tp0rxr933mrLiYHj625LIaukbRtZ+CHf
 n7f2k8g5FvTkWEGf32GQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqvte816s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 01:28:43 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cbb467e56aaso2048499a12.1
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 18:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785374923; x=1785979723; darn=nongnu.org;
 h=content-transfer-encoding:content-type:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=z+6qeAlJOKKWo1FncvQKP0fGn79PFWfQcGh4oQBRHxU=;
 b=XRJswpR/xrZlSel6W2b+H2HIZLJp9l05AtanGuR0wSp+GI3ry506uD143nEUwAvOcs
 Ey8V9F9k3h8uhZ1mLe6ugNGRC/aeR+AnBXECuJIUtAJHbBxs9aBsw4ts3461HYpjpT1L
 Mc0IWDfGfTqt8VwP6pZnAqXeAXdnJ0cgOqZ/HzkBwaZK+mMrt+N/gH7308CFwaMeP1JX
 2/zQNyZqByViLW6SPekwYJX4GaFtbxQaGpxZaNwJr1dCyB09VjUtRhxLJysGJwnVPxvO
 Q3SIILq70cHMv9MBKHKRjPZDBrfQ9rgSYUZ+MXx89rGzzZzCXFDVR8sedu3C64anKayC
 5Trg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785374923; x=1785979723;
 h=content-transfer-encoding:content-type:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=z+6qeAlJOKKWo1FncvQKP0fGn79PFWfQcGh4oQBRHxU=;
 b=BE31DLRjGHDOVh+Ue3FlWQR+ViCouzpYTqKY2CrAoy79r9315D0jO2Hnqxup0+yTEi
 opkGort6kbQ2JGpzC7CTZRU2HEP1QDk+fdH7wq0fbubJ3nf5are5R9q9xd6NKEHmxDfo
 wHCX13b3fNOmjR9y94INyELtTbOQmEbUT6Hk4ElPbJXfCVZOTRYdqwO9aYyhRalkXPPY
 LVzcK6gtiZJiOPlpazaSwyoBuO0C3HtVFYSV2rzfv4vSbfdwbYwOqup/koJcsnsB3Ti8
 bkB5md3iirxpCzi9g5YAuFOiRaus5nQS15hMs+X5DWeFYESAYK7kGOh9iy5jxFsn8FL5
 oNaQ==
X-Gm-Message-State: AOJu0YxGBRcO0Wg2+BQiequhtPJ0eKR5S1DHbLDtkfkcgUZBHk25+sjI
 5k8maLBZc0YB0OCSOZnSKvaT78BeWrrEC1YvFWgYj/nvqyVI38sut3TBlWBmA2VOfEdudg9Dg5Z
 +utecSCGca1MCDOPRxH1LXwrrdhvz84ET1DMsSpfXzyUGFYzyRAve3pBI0xFFaQ584A==
X-Gm-Gg: AR+sD10wqfV1PFB0FTZ3fPr3xe75ORJ2YhAdHaIL0NXKc9FFZMs5TO5cLPhE6+RFnZA
 grr5d2c8/y3VrvFnTOrwD1JEs9SbNiW/6uB19+9HVHDwhipPpiO6/Q5jMErsZTfJLY5fg6Q/fpL
 87ZMYId2P+tDUDchWLqNZ0A88/UPstLqltv87H3Hqwc2VexEUoU68tQgWSnDjBENwh/++iGxchf
 xtyG7Z5P2KAFxBKLaGGsg8P0K0XQ+6DR3Iirdtnqey4YESfQucNeVbiRmDtQLtXRl2RtkxXbZbD
 /UUwxPFFHjHwAVG2oX2gwC32kGOj2ELx9KgcxvMhMQAEgwTH3j6tcJOvQbiRLsEQUe6zesOw+LG
 JRyzz1mzsU2ylKIUWMT8d12/eXeSNMry+dcXRHM6R5cnTurWC
X-Received: by 2002:a05:6a20:7fa3:b0:3bf:6011:53b with SMTP id
 adf61e73a8af0-3c9007ef3famr435940637.38.1785374923256; 
 Wed, 29 Jul 2026 18:28:43 -0700 (PDT)
X-Received: by 2002:a05:6a20:7fa3:b0:3bf:6011:53b with SMTP id
 adf61e73a8af0-3c9007ef3famr435914637.38.1785374922804; 
 Wed, 29 Jul 2026 18:28:42 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31504dab0f3sm13242162eec.27.2026.07.29.18.28.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 18:28:41 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: philmd@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 matheus.bernardino@oss.qualcomm.com
Subject: [PATCH v4 12/18] hw/hexagon/virt: connect pl011 UART interrupt
Date: Wed, 29 Jul 2026 18:28:17 -0700
Message-Id: <20260730012824.1135905-13-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260730012824.1135905-1-brian.cain@oss.qualcomm.com>
References: <20260730012824.1135905-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: OqyAhKzBGumNqu43VmVPRpINcfuFfqFp
X-Proofpoint-ORIG-GUID: OqyAhKzBGumNqu43VmVPRpINcfuFfqFp
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDAwNyBTYWx0ZWRfX4EXYQp9e+TO1
 FAhlnmpYg2oi001hggDfQcenfBZW4JIUg60VfqGhRyH1BZYzb/JlgewowfTf5ehZ8S+PRk56pMD
 ql+NYZHbhwItfBeHEI1kb1KcXhm5ZRc=
X-Authority-Analysis: v=2.4 cv=Tr3WQjXh c=1 sm=1 tr=0 ts=6a6aa8cb cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=Z4HElfRGeH4uGo3IGfcA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDAwNyBTYWx0ZWRfX4Xgy10zOOviV
 bcDdSID2hh8HYJRAxgQ/TC81ayGnX8/FHbcN+rLuYdXaQufdz/S1AFyAOBMTy835YiQN1iVhbpZ
 +4dyQSWkol8D3Poilloy4Gw5gjtn8fqKjvBqD8ZeSjgeKf0og/452vD8nGem3XiRtxMJhDOM1fj
 SIr7ah5g9HaUl+D1BpXuR7NSYH80cxaCjP5oW+g3DdDEg+LPVbO+0XZ8YoqZaIY3DlrAwDDa03C
 nefEC/D7cSFfNZj9TeIDwlI4M8ryZQl4KXhJU4R3qxNTF4eEpZ8RIYmddamIPobhtM6/vadSDDV
 WMI1/nrsXY76UK/JV6o10SDJDicxVWWaCR81BoVDcuqiILJSTrPNSjWUj37lgif28P+WpD+E2vo
 u3b8qp2kPzaEvz6J0yGt/ctamTv7WG5U4Xh23i07RCBVYt1JxiY79y84pRWZIAAee5kBPLxxmSY
 st2QlwWj7wMf4enikSA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_09,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 adultscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300007
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
eTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBvc3MucXVhbGNvbW0uY29tPgpTaWdu
ZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQog
aHcvaGV4YWdvbi92aXJ0LmMgfCAxMCArKysrKysrKy0tCiAxIGZpbGUgY2hhbmdlZCwgOCBpbnNl
cnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2h3L2hleGFnb24vdmlydC5j
IGIvaHcvaGV4YWdvbi92aXJ0LmMKaW5kZXggZWEyMGVhM2M1MGEuLjY0ZDgzNjZkMjdkIDEwMDY0
NAotLS0gYS9ody9oZXhhZ29uL3ZpcnQuYworKysgYi9ody9oZXhhZ29uL3ZpcnQuYwpAQCAtMzks
NiArMzksNyBAQCBlbnVtIHsKICAqIFZJUlRJT19JUlFfQkFTRSArIFZJUlRJT19ERVZfQ09VTlQg
LSAxCiAgKi8KIHN0YXRpYyBjb25zdCBpbnQgVklSVElPX0lSUV9CQVNFID0gMTY7CitzdGF0aWMg
Y29uc3QgaW50IFZJUlRfVUFSVDBfSVJRID0gMTU7CiAKIHN0YXRpYyBjb25zdCBNZW1NYXBFbnRy
eSBiYXNlX21lbW1hcFtdID0gewogICAgIFtWSVJUX1VBUlQwXSA9IHsgMHgxMDAwMDAwMCwgMHgw
MDAwMDIwMCB9LApAQCAtMTQzLDcgKzE0NCw3IEBAIHN0YXRpYyBpbnQzMl90IGZkdF9hZGRfY2xv
Y2tzKGNvbnN0IEhleGFnb25WaXJ0TWFjaGluZVN0YXRlICp2bXMpCiB9CiAKIHN0YXRpYyB2b2lk
IGZkdF9hZGRfdWFydChjb25zdCBIZXhhZ29uVmlydE1hY2hpbmVTdGF0ZSAqdm1zLCBpbnQgdWFy
dCwKLSAgICAgICAgICAgICAgICAgICAgICAgICBpbnQzMl90IGNsa19waGFuZGxlKQorICAgICAg
ICAgICAgICAgICAgICAgICAgIGludDMyX3QgY2xrX3BoYW5kbGUsIGludDMyX3QgbDJ2aWNfcGhh
bmRsZSkKIHsKICAgICBjaGFyICpub2RlbmFtZTsKICAgICBod2FkZHIgYmFzZSA9IGJhc2VfbWVt
bWFwW3VhcnRdLmJhc2U7CkBAIC0xNjEsNiArMTYyLDggQEAgc3RhdGljIHZvaWQgZmR0X2FkZF91
YXJ0KGNvbnN0IEhleGFnb25WaXJ0TWFjaGluZVN0YXRlICp2bXMsIGludCB1YXJ0LAogICAgIHFk
ZXZfY29ubmVjdF9jbG9ja19pbihkZXYsICJjbGsiLCB2bXMtPmFwYl9jbGspOwogICAgIHN5c2J1
c19yZWFsaXplX2FuZF91bnJlZihzLCAmZXJyb3JfZmF0YWwpOwogICAgIHN5c2J1c19tbWlvX21h
cChzLCAwLCBiYXNlKTsKKyAgICBzeXNidXNfY29ubmVjdF9pcnEocywgMCwKKyAgICAgICAgICAg
ICAgICAgICAgICAgcWRldl9nZXRfZ3Bpb19pbih2bXMtPnBhcmVudF9vYmoubDJ2aWMsIFZJUlRf
VUFSVDBfSVJRKSk7CiAKICAgICBub2RlbmFtZSA9IGdfc3RyZHVwX3ByaW50ZigiL3BsMDExQCUi
IFBSSXg2NCwgYmFzZSk7CiAgICAgcWVtdV9mZHRfYWRkX3N1Ym5vZGUobXMtPmZkdCwgbm9kZW5h
bWUpOwpAQCAtMTY4LDYgKzE3MSw5IEBAIHN0YXRpYyB2b2lkIGZkdF9hZGRfdWFydChjb25zdCBI
ZXhhZ29uVmlydE1hY2hpbmVTdGF0ZSAqdm1zLCBpbnQgdWFydCwKICAgICAvKiBOb3RlIHRoYXQg
d2UgY2FuJ3QgdXNlIHNldHByb3Bfc3RyaW5nIGJlY2F1c2Ugb2YgdGhlIGVtYmVkZGVkIE5VTCAq
LwogICAgIHFlbXVfZmR0X3NldHByb3AobXMtPmZkdCwgbm9kZW5hbWUsICJjb21wYXRpYmxlIiwg
Y29tcGF0LCBzaXplb2YoY29tcGF0KSk7CiAgICAgcWVtdV9mZHRfc2V0cHJvcF9jZWxscyhtcy0+
ZmR0LCBub2RlbmFtZSwgInJlZyIsIDAsIGJhc2UsIHNpemUpOworICAgIHFlbXVfZmR0X3NldHBy
b3BfY2VsbChtcy0+ZmR0LCBub2RlbmFtZSwgImludGVycnVwdHMiLCBWSVJUX1VBUlQwX0lSUSk7
CisgICAgcWVtdV9mZHRfc2V0cHJvcF9jZWxsKG1zLT5mZHQsIG5vZGVuYW1lLCAiaW50ZXJydXB0
LXBhcmVudCIsCisgICAgICAgICAgICAgICAgICAgICAgICAgIGwydmljX3BoYW5kbGUpOwogICAg
IHFlbXVfZmR0X3NldHByb3BfY2VsbHMobXMtPmZkdCwgbm9kZW5hbWUsICJjbG9ja3MiLCBjbGtf
cGhhbmRsZSwKICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNsa19waGFuZGxlKTsKICAgICBx
ZW11X2ZkdF9zZXRwcm9wKG1zLT5mZHQsIG5vZGVuYW1lLCAiY2xvY2stbmFtZXMiLCBjbG9ja25h
bWVzLApAQCAtMzQyLDcgKzM0OCw3IEBAIHN0YXRpYyB2b2lkIHZpcnRfaW5pdChNYWNoaW5lU3Rh
dGUgKm1zKQogCiAgICAgZmR0X2FkZF9jcHVfbm9kZXModm1zKTsKICAgICBjbGtfcGhhbmRsZSA9
IGZkdF9hZGRfY2xvY2tzKHZtcyk7Ci0gICAgZmR0X2FkZF91YXJ0KHZtcywgVklSVF9VQVJUMCwg
Y2xrX3BoYW5kbGUpOworICAgIGZkdF9hZGRfdWFydCh2bXMsIFZJUlRfVUFSVDAsIGNsa19waGFu
ZGxlLCBsMnZpY19waGFuZGxlKTsKIAogICAgIGhleGFnb25fbG9hZF9mZHQodm1zKTsKIH0KLS0g
CjIuMzQuMQoK

