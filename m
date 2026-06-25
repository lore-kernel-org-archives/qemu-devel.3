Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61D23CDB479
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 14:51:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wclNk-0002gc-89; Thu, 25 Jun 2026 10:48:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wclNe-0002fp-1t
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:48:38 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wclNc-00008c-Ii
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:48:37 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65P9jwHK1371465
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:48:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KM8Vmh2bjk7TYidhmOrqAPOj1Wp2rd3I7ixjJkyml2o=; b=hdrxanV8Hfo/gSrf
 IEy8gOrRHrlM62QjQPyak3nGYIGZ4gKKe+CO2RzS0JIg7pyouNhplQMrGTiM8mom
 KEHUjGCgXt3E7ScwCLZNmV7K1Wo45GwW2H8GJ1A5xzOJ3+aAIE25zLEmxZkqtVFH
 rvbB1o2KeWpGtTCpn5wMVc6Ok3lrFX3scJR+Dty8WN2BViAv/bKLgyfv6PLkRDqb
 7FrfHrE0fesbdVcdNivD4DetUn90e5kSortFkcID1XBJsub4XOYMvZGwTpqHE1Qs
 5/qlD1aDroowyuI/czuFT9YEbKkrFWkU7ma8au6ZoyckbJeJd17qIAFQJ97ZK0Rx
 FmHvKA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0ymv1r1p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:48:35 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30c0a27ad86so6613181eec.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 07:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782398914; x=1783003714; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KM8Vmh2bjk7TYidhmOrqAPOj1Wp2rd3I7ixjJkyml2o=;
 b=KOkyxlm32zyHVZOLVxGKa+kQJtuc+7tjZX1x1JamC12gTNOWMtQuNG2hvG0t9VD1Eh
 bhAUjQeoZ0FwoxVnRgm27yd8eCON+oAnxAYQ8/DpL7k/GuhOfyCBXjIcnB7l8s5fC5xO
 B6f/qlBIVGl4Ov0b2PLkLip1SV7lGQJvKYSRpEu28flT1pjxb+iXX52QhDWGmV3QuGpr
 bkRYVHWzCw7PCSbdZ4/HnKBKxoW16nB9PZSvrjRoo3B58tltQG//Iq/RQp6BAdDdSCIi
 TXy+i0xfoKfX5soBA3ofX93Sn0feKX+7fhuJjCec1UffmuyySPp1GXno8sIOHlltQbcf
 pY8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782398914; x=1783003714;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KM8Vmh2bjk7TYidhmOrqAPOj1Wp2rd3I7ixjJkyml2o=;
 b=TO5ovX6lIOQasj059Fmjpnc9Ibngez7k3PXekcSudVRcHHAP0UHQkqM6HeIXtdz25c
 lW26wafnYuX3otfioDEAb4Rr14Eod9sku571GXYQjQ1NZo/GgBYAEWqNof0XdNhO51HK
 vIlj7/jby50oeatHVfmrhzeurvl7sG0Gwh9nFv22/Qzx1/o8iG/X4ppcp82GCZ11dvEZ
 7mXtSGzJsU0oxbry6/7J5mqEUK9bh30mHNePfDIHM14SiKgnRAaBoMzDe3O66CSScz11
 P11Hyu8BkdiaXL3Q4jMwp6HyeCOzJZwTy6AvO0IN2Wj5ZA2hD9Fz050SabdzmjxwLPd7
 ZYGg==
X-Gm-Message-State: AOJu0YwODFf0qXMp9N7R9q1AWnxbznhWuchYkF7mXt8g5xFcfO0IIGB9
 rQAwuHd8qyQP2oTMHHhEU9PzDsK8NzxGFBzRgH5U/z0a8dEMFOqADE3t67AQcR7ALQg7wl3XkZm
 ccI5wnpqacNCXH720SUkx0ehTTF1rHMjXWSX3HgCoLSaj9jRtZzV3TEY8Gk0Pmazaug==
X-Gm-Gg: AfdE7clI4Y/ITViOHagwDO4z1gi7xL3qNRqLMLUIDX/GiHfgvSzHVQ3wasLrEY7eG4o
 DSY6WlTW9dp5udLhcU4iKBBnZvPx+vLhyaVYwsGI1rPv6QvWabYto+kyAnvhpO0UocrVvVrIkMT
 uuSmjIW0BotGB1Uc6YIReNM/kValg4tfmc6pJcYPjTZG+j5LAPiBnnAYZWFtNANrUwr4JG0hKBq
 dDhgfPUJczT1nMwJDark45mzD3w6YvWB6CxQvk8uVtD4Pawf3Qec0Om0Rr7Jgg1C1RGTnQjUSq0
 4/Jtbkj3fYq9ZGLX0aOGG2C0R5A7nkzmcZy7OcPqF2EypQPw5fJqy/P7zGNbFGEaEuKHkSo+CIu
 47RrbhJElB891o/EEjAc6uIWnBy6z4e/wi68KgX9LCSx7OBw9MK9CUKGSo7M=
X-Received: by 2002:a05:7301:5f84:b0:307:37a4:15dd with SMTP id
 5a478bee46e88-30c85009ea4mr3814609eec.26.1782398914422; 
 Thu, 25 Jun 2026 07:48:34 -0700 (PDT)
X-Received: by 2002:a05:7301:5f84:b0:307:37a4:15dd with SMTP id
 5a478bee46e88-30c85009ea4mr3814560eec.26.1782398913850; 
 Thu, 25 Jun 2026 07:48:33 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c8afca8sm8999209eec.17.2026.06.25.07.48.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 07:48:32 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v3 57/76] target/hexagon: Decode trap1, rte as COF
Date: Thu, 25 Jun 2026 07:16:14 -0700
Message-Id: <20260625141633.449487-58-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
References: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=DqBmPm/+ c=1 sm=1 tr=0 ts=6a3d3fc3 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=oDs3gbQtVgqjpHJ5GUgA:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDEyNyBTYWx0ZWRfXzZojR0t+eJ9v
 XelGGnNTmlpTyzib7h0vAVPnhtMlhE8qSwWaTTpatlJcuGepAFgACBauanihwfJcSIYbosfgour
 C6Njft8TL8Qf5BWLlMtThMpJQ3TFzPM=
X-Proofpoint-ORIG-GUID: DLD-nVjV-7n7pGt_UY3YrZdNimnahtwL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDEyNyBTYWx0ZWRfX0RwC0Al9ToTu
 mJYnFFEm5UDbGAC11cXTYWSctYLgBNeU3nO0IHVDiXL/Y4fvs9bknG64p6EXxLYHgpvNdhEtqks
 pnSPaTFtVISXiwZB6sQDu3ESiL5oK8Ei/LMGDTnb3lD7I3xnF3r+/QIjxhkCmJFgJK36rMN7ZV5
 NK4MaPizqKPB0zd3q5BTCUooGEGBMoVh9XN8ng09gOPp2TJbPDy0y4eYyw+74//Xx6ciR2YXZe9
 iit77m1vXUmSm8mpqG1JFNgFeZGJzG27h2UwpIYFBH3TLes5H3YnLOvuXrp6lKtr+53UHLv7thZ
 GOQ11aAoMpggjXdHseMdYhba+AV2E0mEDh64D98UyKO+oJCwakLzaTQFLI7QsKpFUyRz19j6M8q
 HJOC+ZJuBXkqEgfmDrbaP8Cmoo1s1Eb/s1R6B+LbO6Vbb0d1OY1B87d8fUJtMEz8MqJgYc0rkag
 9b3XhXvHjxxxFpHyqhw==
X-Proofpoint-GUID: DLD-nVjV-7n7pGt_UY3YrZdNimnahtwL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606250127
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpBbHNvOiBoYW5kbGUgcnRlIGlu
c3RydWN0aW9ucyBhdCB0aGUgZW5kIG9mIHRoZSBwYWNrZXQuCgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2Rl
Y29kZS5jIHwgMTQgKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25z
KCspCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vZGVjb2RlLmMgYi90YXJnZXQvaGV4YWdv
bi9kZWNvZGUuYwppbmRleCAxNTk1NDUxOGI4My4uNmVkZGNjYTI2ZWQgMTAwNjQ0Ci0tLSBhL3Rh
cmdldC9oZXhhZ29uL2RlY29kZS5jCisrKyBiL3RhcmdldC9oZXhhZ29uL2RlY29kZS5jCkBAIC0x
ODUsNiArMTg1LDggQEAgc3RhdGljIGJvb2wgZGVjb2RlX29wY29kZV9jYW5fanVtcChpbnQgb3Bj
b2RlKQogICAgIGlmICgoR0VUX0FUVFJJQihvcGNvZGUsIEFfSlVNUCkpIHx8CiAgICAgICAgIChH
RVRfQVRUUklCKG9wY29kZSwgQV9DQUxMKSkgfHwKICAgICAgICAgKG9wY29kZSA9PSBKMl90cmFw
MCkgfHwKKyAgICAgICAgKG9wY29kZSA9PSBKMl90cmFwMSkgfHwKKyAgICAgICAgKG9wY29kZSA9
PSBKMl9ydGUpIHx8CiAgICAgICAgIChvcGNvZGUgPT0gSjJfcGF1c2UpKSB7CiAgICAgICAgIC8q
IEV4Y2VwdGlvbiB0byBBX0pVTVAgYXR0cmlidXRlICovCiAgICAgICAgIGlmIChvcGNvZGUgPT0g
SjRfaGludGp1bXByKSB7CkBAIC0zNjMsNiArMzY1LDE4IEBAIHN0YXRpYyB2b2lkIGRlY29kZV9z
aHVmZmxlX2Zvcl9leGVjdXRpb24oUGFja2V0ICpwYWNrZXQpCiAgICAgICAgICAgICBicmVhazsK
ICAgICAgICAgfQogICAgIH0KKyAgICAvKgorICAgICAqIEFuZCBhdCB0aGUgdmVyeSB2ZXJ5IHZl
cnkgZW5kLCBtb3ZlIGFueSBSVEUncywgc2luY2UgdGhleSB1cGRhdGUKKyAgICAgKiB1c2VyL3N1
cGVydmlzb3IgbW9kZS4KKyAgICAgKi8KKyNpZiAhZGVmaW5lZChDT05GSUdfVVNFUl9PTkxZKQor
ICAgIGZvciAoaSA9IDA7IGkgPCBsYXN0X2luc247IGkrKykgeworICAgICAgICBpZiAocGFja2V0
LT5pbnNuW2ldLm9wY29kZSA9PSBKMl9ydGUpIHsKKyAgICAgICAgICAgIGRlY29kZV9zZW5kX2lu
c25fdG8ocGFja2V0LCBpLCBsYXN0X2luc24pOworICAgICAgICAgICAgYnJlYWs7CisgICAgICAg
IH0KKyAgICB9CisjZW5kaWYKIH0KIAogc3RhdGljIHZvaWQKLS0gCjIuMzQuMQoK

