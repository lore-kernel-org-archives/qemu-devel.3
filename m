Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AB9BCD98F2
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 23:00:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waiBT-0001cr-IE; Fri, 19 Jun 2026 18:59:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waiBR-0001cb-S9
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 18:59:33 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waiBQ-0001X9-Bm
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 18:59:33 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65JLZQhi4088148
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 22:59:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=qd0MRjIIozbImbBr0lnxAdZmpDNRrMGNSs+reFaWXjE=; b=IZ
 kgCxThqEfDUcTMGy+0/AnqUXEyH+PFfMZJe5oYgvvU7SBaZrpxII2GLZifwFQrpv
 TzClUoMnf+mU+CF9nC9IBxZLWxUGWw18YO1xx3njgQJb7GRs5h9b8Pk49cq4NQIO
 1hRGNQVI8FAo+vAgE33i1Yl8ObPmtZPiJJSQmz2x7DCCcCwhoujv710uroH6aJA5
 cyIl6/80Lmf+dZeRR3wN0G7wDDmLw7BxrZar2xeiIkDOcWZN/YsHm2+4M07RJldO
 9Jml2W0eXiXLmgL7ORq9IotuQKvMQV6RiyskFS4Fuo8YlAsT7knmN4tCD3sFUV0b
 ea2ku1yegaVd6xKPkUSw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evmyrdj1u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 22:59:30 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30c0c489e72so971481eec.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 15:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781909970; x=1782514770; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qd0MRjIIozbImbBr0lnxAdZmpDNRrMGNSs+reFaWXjE=;
 b=WOBbWQ1P00hkX0JLSAgW5kCMr5eC31Hj1tuu+Nx9tEsHlfZ7CfHJAyITgcHt98fJOy
 VT2iQ1LeD5Zy8Lj0s+VxPyNJnFz2J2rF0Tr+czX4IGH1PnQw8tUQ3l5gZaLsSIP1G89T
 b+4AevY/+KpKkETkyDX/LHAbEH5Mw1Ex5VFRbqqZF+Q2HpmXTWVRkGIiDkUKHP/2Acy0
 zWdq6ahKoNQ9VPQp8YQRpv30Hkpp6DQs6dTfOQWCfKZKllN81ZQXbsOIpr4fWi+gOEE/
 LdkeENNe/y+0byp3OG6iuv4c5ndzKM4aeqgV2P7SMQWgmxSHobzZxRlT3gBV3TjojWBP
 JkBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781909970; x=1782514770;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qd0MRjIIozbImbBr0lnxAdZmpDNRrMGNSs+reFaWXjE=;
 b=Pv75lXnhg9tb9zyhQj2Q0Apt9JOETAnOqlBBE2mpkcDkux4BscN11Zw2b/EA77j5ir
 8JAedrDf8IpMAUjP4asTut6QMVnF6oIDmM5oS3n1+lWWYhGE81NHQfzZWM0J+q2/zCAt
 5zKEFhZMD0gaf3sZcMDmjP1rsnFHrREHmYCjHy2Ze6K0VC1fxGblqxST8VdY90NQm15W
 WqKTEMfeYr73iNNUA+2Eq7RupWPLLxgFV9At7FB6GVkacoIAWRwptwfyrUGhN2ZlEzpO
 NbtHzlcdIuqrU+3rIdpd4kAtddKof7VGjb6cBI8cIKu8mFtINlLKV3AYX31oCf8B/c44
 E/fw==
X-Gm-Message-State: AOJu0YxOTslmCRY4XJU1JfnUF5JkUpoTf1Q+Ba+if8WV6vLtNtjVGHZT
 3sHsu9ZslHt4LR4GMVzIK0lS6Y2eIDV/9TxTBoVEmIMBP0inLEWuntgRihWoiEAI0X6B7Lp0Y2M
 idAIJCNy+fQKnobVzpi43XjPwUKKwllEEPpWFVZp50TC4epfAq98MGtp4cavk7ACIeQ==
X-Gm-Gg: AfdE7cnf8kTAHZCfWY2XKQB8bz6LQnavp4zyrTWVGrd18c6lBg1x7MGzPKgcT4r05QC
 8xzEUyPe2rMZXnkx4e7VEV56uxhZmYOq8mjjVxTxfLmIhFcBilgi4m7TnFZSHmOtT+am2bH7Jj0
 Jkf6cV/OUdg4WLcSoC8NuIHEXV9My7BFx19eeCLODtU2TXEtuY0bhw2ItmVWi/EFeKyffYnopiB
 CWwJtIxCmPQnKVF+63tDgzrX46y3izqkQw+wT5VimXkPRY5IJWHH6aositVLACfCCxrnsgXFM0N
 GIN7hI9Rv5X/c118e8qX+zEtX9ntDHwDw5FwvjIGMuJYOlg+GGq3NMDS/Xu7Jdy5kA/xiN4EeP0
 Ev1VAEnmyTFf1LowtsbVfNvrVBvfbfI3CnC41x9/C+HnpwlP515Zknrfpk3g=
X-Received: by 2002:a05:693c:62d2:b0:30c:1739:67f7 with SMTP id
 5a478bee46e88-30c173968e6mr968992eec.35.1781909969988; 
 Fri, 19 Jun 2026 15:59:29 -0700 (PDT)
X-Received: by 2002:a05:693c:62d2:b0:30c:1739:67f7 with SMTP id
 5a478bee46e88-30c173968e6mr968982eec.35.1781909969522; 
 Fri, 19 Jun 2026 15:59:29 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1b4f7d81sm1309510eec.0.2026.06.19.15.59.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 15:59:25 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 09/74] target/hexagon: Add a placeholder fp exception
Date: Fri, 19 Jun 2026 15:58:06 -0700
Message-Id: <20260619225911.159473-10-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
References: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=RZWgzVtv c=1 sm=1 tr=0 ts=6a35c9d2 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=R5LHHePp8dzqxDYlWrYA:9 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: aIII47b7hIJQ5_4p5SH-RzpTk_2TPZhH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDIyMSBTYWx0ZWRfX9l1Cj5sgowFR
 H6hHg+sNSW7T8U/CCWw/qBsEnAt52ApUK3EdwLa7LbU1Yv+kszzAVTPqh90ybRbyBjpd2YzR7q/
 BM/mrhE0DGn42972ucRIPG9l1OZK83twVlqvOC5bKddB8QBUGGWO9GruuzfafhwAAlrBxmFXDX3
 jW6gtWWna58ITMidhLK0ON0ZBOXf1SUC5McyNWalM6aZxzCRGCk/SN1Wg6aoIU65UYBH3p3ZdCs
 LS+XMUUYNhIViQXZYFqL3xOpJADaDGi7bkywgpyE4dkUALhYd4dcS/qVll7rUmgoNQUfiC2aTRD
 fIGmRKZienuUtS4HV6/A3T/ZmA0JO3l00vraWasYQNSbn8zgtH1qLRnaxbxdOCxm9kmyQ3CTVyB
 C6Q9awf7Gke/q0dU9sKQjYLVSVzpUxGzmEYPUakldGhqLqWsjWErot8fibi30fGUKFiCsTdGRek
 peLwTRhiJUGi53F/qdQ==
X-Proofpoint-GUID: aIII47b7hIJQ5_4p5SH-RzpTk_2TPZhH
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDIyMSBTYWx0ZWRfX1nt3ayXYKr77
 L1L1AcmKXHepkBY9/IGpoA+0aWAgtSjgmCiGUee4O8gMwXGG6W1cqe0OEEkj2PLXUXtBlPti93Y
 kVStCparivHp4VqBRky1TmS/9BT3fj4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_05,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 bulkscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606190221
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KUmV2aWV3ZWQtYnk6IFBoaWxpcHBl
IE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2Fy
Y2guYyB8IDUgKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykKCmRpZmYgLS1n
aXQgYS90YXJnZXQvaGV4YWdvbi9hcmNoLmMgYi90YXJnZXQvaGV4YWdvbi9hcmNoLmMKaW5kZXgg
ZTE3ZTcxNGE2YWMuLjBhNDAwYmY3YTc3IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9hcmNo
LmMKKysrIGIvdGFyZ2V0L2hleGFnb24vYXJjaC5jCkBAIC0yMDgsNiArMjA4LDExIEBAIHZvaWQg
YXJjaF9mcG9wX3N0YXJ0KENQVUhleGFnb25TdGF0ZSAqZW52KQogICogbW9kZWwgaXQgaW4gcWVt
dSB1c2VyIG1vZGUuCiAgKi8KICNkZWZpbmUgUkFJU0VfRlBfRVhDRVBUSU9OICAgZG8ge30gd2hp
bGUgKDApCisjZWxzZQorIC8qCisgICogVG8gYmUgaW1wbGVtZW50ZWQuCisgICovCisjZGVmaW5l
IFJBSVNFX0ZQX0VYQ0VQVElPTiAgIGRvIHsgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsgfSB3aGls
ZSAoMCkKICNlbmRpZgogCiAjZGVmaW5lIFNPRlRGTE9BVF9URVNUX0ZMQUcoRkxBRywgTVlGLCBN
WUUpIFwKLS0gCjIuMzQuMQoK

