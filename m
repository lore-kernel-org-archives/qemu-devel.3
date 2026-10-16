Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C061CCA46C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 14:30:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHiwu-0004mm-2F; Fri, 16 Oct 2026 10:30:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xHiwr-0004mL-9r
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 10:30:17 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xHiwp-0007e6-C1
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 10:30:17 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GE671g2455244
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 14:30:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=lXhu27j52F7vAs6ru9gktY
 fjL+p/slwUXwrfEVY14WA=; b=kcX2ueANkNC+v2K3ENXrSvHDXavDGbXMjKA6Ap
 PqKz3fFDmw3fX7Rv4PHyAcRukX+zSq6PQddZ4J172e4nLJElSz//dg0mx60DroIC
 eL+sVHQe5Q6MFB8oY3jrpqMcZw/Q8TbJKMeH0pZcDC0Gq1hPMt54Za7Cc839hHOp
 7FZAISkkzeT9mC45z2YlH0zJdB5+1cyp0UIJkBITmE9OcWp+3hQGG6rI8/pxj2T2
 EV2GPGHIdsdXWae49Sep/htDirjoK83VHATB85UT3jUhKEpOMPTF9dSdbYXtIJ6I
 6sMxZ1EujpCfhXXYxdYSOSDT7kvrkMkCYqkrLJYQQWJMzOMg==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbg5yscxw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 14:30:13 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-5e96f90659eso960627e0c.1
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 07:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792161012; x=1792765812; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=lXhu27j52F7vAs6ru9gktYfjL+p/slwUXwrfEVY14WA=;
 b=dUqhWIhLs9QBtuzsVPdamRL4VIrKO29Rnv1ZgEI1bBfMRaflFiGyY5AY7Oi9PUYOqK
 fK1u6XSjsMPnqOABSiHFqwWzTRROoMDVmgFtYGf2cs2WHAxEh0WrnoIw2+nwuWG5EYH+
 gwfsrC013G4/haI1eOueuqF1zfy+8IKE/aZ0b83zjZXcQlx0gBJVYDbJ7QzP/LjeV4eL
 U0QPKls9FjxInqzQXofwOv15CrfAQlTobnJN+wQW2c1icnydIeS34YbnDaSglJSjcNvu
 cDrJVcmKmRsTNG/7lSq5weAxzIvbcNxH9TboGwFG1Yip7vETk/UVcRYbXBZsRTdcpIA8
 +qHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792161012; x=1792765812;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lXhu27j52F7vAs6ru9gktYfjL+p/slwUXwrfEVY14WA=;
 b=AvIksKLbo198qRXO7mTUme1xiK82D10AkA9zXxsL5XvdFWrSOydrrTJ7DAP4XghpLt
 izUe6roKyCtLoJl8a49HlSYr73po6NIFV7SxHvn/AbSIVmyGWuaAJjuuvyQIGCZSiXaX
 etGgaqZ3HPIqAk2NZpc2EdsLaaiPLsVoKkZcAF+5zrsk0jC8STSM79m4r4qeczJMeqwN
 B0AD+ZxjIqRe/ciVTXW+zgXKmYvFwxj40Vmig6FmCy7S1Gu6t2H0TIzsxw4bQBI5HW4R
 26fEVEYKbkSOBLa77mGyHhf1et4qeC8wMtDpmDS4sKkjVmZO8D/La/zYIinrHoQx6j8B
 kkLw==
X-Gm-Message-State: AFq9FYJ6ItFlpOzPmeftKQREGUhCOerO95ziRyKgAQv9GcpIg7qTqpoH
 iBV5Zx9rn2qBGJULhaQBa6UWuidx7BesbhLM4Et/E7egNrzOl3HYhO44ry0zOljvc5nyu6JHqME
 G/CNrFDlpFnyuxd20QVp1OqE7+UMgc7PYToqcyUtyZ4zp9fOQdZW52Ouihjw8i9J/qQ==
X-Gm-Gg: AYBFou2UgZMZw0no3mot2uOBdvTxIVB482MYPsKRw7Qep+qK/qlJlwaWpwxC0gOjUdO
 oEPw/c7QStBdhKKj/N2lIWXYOYpMAi35015Owfh8sqWJmjw2C8BuJ51480rzfJYAM6SvS93zamR
 zwgmzX9nsmFijckvay9wmVeU79/ji0jQUrsoa2oJqJACbnkxywPPUk6d+iW8NmudNDPsYPFNrX0
 myqAYWNUnio+PpgoJxsm/JEcw7oND1t7Xdi/IRf5zjWJf3tDIxfpZkgLx4h4wJoG9eWQPbMwZF1
 pOnmHWfw9vmH3+KHDi2knN3LFkfgpjXj4x+FukZS1mbCceV9HWCINJrwNKzttySntVUCt0Vrov4
 2V3pSXCVo8nlQBGG2rp9rp1FQ5lgMnnJBlvc2PbrgdGXOR4s=
X-Received: by 2002:a05:6122:685b:10b0:5c2:ac92:eb18 with SMTP id
 71dfb90a1353d-5eaaa415087mr77175e0c.7.1792161010831; 
 Fri, 16 Oct 2026 07:30:10 -0700 (PDT)
X-Received: by 2002:a05:6122:685b:10b0:5c2:ac92:eb18 with SMTP id
 71dfb90a1353d-5eaaa415087mr77140e0c.7.1792161010163; 
 Fri, 16 Oct 2026 07:30:10 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5ea9b474b2asm1605214e0c.4.2026.10.16.07.30.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 07:30:09 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: philmd@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 peter.maydell@linaro.org, Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v4 0/4] hexagon semihosting: Address coverity finding
Date: Fri, 16 Oct 2026 07:30:03 -0700
Message-Id: <20261016143007.3474704-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: h8d8YBKElAnJ-Svruu8ei8Ho2fn4diw2
X-Authority-Analysis: v=2.4 cv=M+HYuCws c=1 sm=1 tr=0 ts=6ad234f5 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=DHhsvDEEjNy1lX6SIIwA:9 a=QEXdDO2ut3YA:10
 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA1NyBTYWx0ZWRfX61O36oiAA7lg
 mtbK2NOC4i3Lkwbhbrf69V2WTACGPyuBDOwjH+gr/SVUjm2gB+LkEKtmofRt/r+yPB0uGm8Hcve
 pbCTbVrW10rhRiFQS4DqY9SJiIRFLIQ=
X-Proofpoint-GUID: h8d8YBKElAnJ-Svruu8ei8Ho2fn4diw2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA1NyBTYWx0ZWRfX1EliS2SdeJGu
 jJW9tSXkKXcmHQDTiGPeydyZEXrPnbMxPH74ubDtHT+w5pliBiMZ3ptovxXlcY1sTjyOCtPYUum
 DSnVudVh8FvAzJQXn1yLa4CTs9FweVwnZ0sZLpskYXx6ldkMSs1VtppS4wDPsIRaBG/bp+01DMX
 fG6tWq0TARskAXKlMLty61a8gB5fwwe2+8DboxDDHbE3WNhdiuOrkxvL2GXl2dk0PWPjfUhb268
 nuPz987QxRV48lhwz9ONH88qRQX0gcXNutS7kL8shgL0cJg82IgvywPo2c/aNBvl+OevUvuX4wx
 fch9aNaPLdFnd5mMo08yCEQm9tRXzJDug6aXXgXZMDIWeC4XA2duZlC5fTbQPA9IRxGziFo0jdt
 GrREeI/W4610x+SRn5jxklZLZE2HYLegiyZMz9vLUTF2/HUJcJ15DYlb4oNvb6fCGqQDDbG5Uec
 D+OyiItknaPaGdW/Zpw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160057
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

VGhlc2UgZml4ZXMgYXJlIHRvIG1pdGlnYXRlIHRoZSBpc3N1ZShzKSByZXBvcnRlZCBieSBDb3Zl
cml0eSBhbmQgUGV0ZXIKTWF5ZGVsbC4KCkluIHY0OgotIERyb3BwZWQgImFkZCBkaXJlY3Rvcnkg
c2VtaWhvc3Rpbmcgb3BlcmF0aW9ucyI6IG5lZWRzIGEgYmV0dGVyIGRlc2lnbgphcHByb2FjaCwg
cGVyaGFwcyB3L3NvbWUgYXJjaGl0ZWN0dXJlLWluZGVwZW5kZW50IHN0YXRlLiAgTm90IHJlcXVp
cmVkIHRvCm1pdGlnYXRlIENvdmVyaXR5IGlzc3Vlcy4KLSBQdWxsZWQgdGhlIGhleGFnb25fcmVh
ZCooKS0+Z2V0X3VzZXIoKSBvdXQgb2YgImZpeCBzZW1paG9zdGluZyBPUEVOIGZpbGVuYW1lCmhh
bmRsaW5nIiBpbnRvIGl0cyBvd24gcGF0Y2guCgpJbiB2MzoKLSBUaGUgZmlyc3QgcGF0Y2ggbm93
IHVzZXMgZ2V0X3VzZXJfKigpIGZvciBzZW1paG9zdGluZyBhcmd1bWVudCBhY2Nlc3NlcywKaW5z
dGVhZCBvZiBoZXhhZ29uX3JlYWRfbWVtb3J5KCksIG5vdyByZW1vdmVkLgotIEZvciBIRVhfU1lT
X09QRU4sIGZpbGVuYW1lL2xlbiB2YWxpZGF0aW9uIGVycm9ycyBhcmUgaGFuZGxlZCB0b2dldGhl
ci4KCkluIHYyOgotIEhFWF9TWVNfT1BFTiBzd2l0Y2hlZCB0byBsb2NrX3VzZXIoKSBmcm9tIGxv
Y2tfdXNlcl9zdHJpbmcoKQotIHB1bGxlZCBpbiB7b3BlbixyZWFkLGNsb3NlfWRpciBmcm9tIHRo
ZSBhIHByZXYgcGF0Y2gsIGNoYW5nZXMgc2luY2UgdGhhdCB2MjoKICAqIFJlcGxhY2VzIFBPU0lY
IERJUiwgb3BlbmRpcigpLCByZWFkZGlyKCksIGFuZCBjbG9zZWRpcigpIHdpdGggcG9ydGFibGUg
R0xpYiBHRGlyIEFQSXMuCiAge3VuLH1sb2NrX3VzZXIKICAqIFJlcGxhY2VzIHRoZSBmaXhlZCBC
VUZTSVogcGF0aCBidWZmZXIgYW5kIGJ5dGUtYnktYnl0ZSBndWVzdCByZWFkcyB3aXRoIGxvY2tf
dXNlcl9zdHJpbmcoKS91bmxvY2tfdXNlcigpLgogICogQWRkcyBTZW1paG9zdGluZ0Rpciwgd2hp
Y2ggc3RvcmVzIHRoZSBHRGlyIHBsdXMgZW51bWVyYXRpb24gc3RhdGUKICAqIFN5bnRoZXNpemVz
IC4gYW5kIC4uLCBvbWl0dGVkIGJ5IGdsaWIKICAqIFdyaXRlcyBpbm9kZSB6ZXJvIGluc3RlYWQg
b2YgaG9zdCBkX2lubywgd2hpY2ggR0xpYiBkb2VzIG5vdCBleHBvc2UgcG9ydGFibHkuCiAgKiBM
aW1pdHMgcmV0dXJuZWQgbmFtZXMgdG8gMjU0IGNoYXJhY3RlcnMgcGx1cyBOVUwsIHJhdGhlciB0
aGFuIGRlcGVuZGluZyBvbiBob3N0IHN0cnVjdCBkaXJlbnQ6OmRfbmFtZSBzaXplLgogIFByZXYg
b3BlbmRpciB2MjogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC85ODIzZjY3Zi1i
ZmM2LTQwZTItYmEzZS1jYjAyZTUzYTQwMDRAb3NzLnF1YWxjb21tLmNvbS8KCnYyOiBodHRwczov
L2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsLzIwMjYwOTE0MjIzMTU5LjI3MzUyNjItMS1icmlh
bi5jYWluQG9zcy5xdWFsY29tbS5jb20vCnYxOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11
LWRldmVsLzIwMjYwOTA2MjIyNTUxLjM3MTI5NTQtMS1icmlhbi5jYWluQG9zcy5xdWFsY29tbS5j
b20vCgpCcmlhbiBDYWluICg0KToKICB0YXJnZXQvaGV4YWdvbjogdXNlIGdldF91c2VyKigpIGZv
ciBzZW1paG9zdGluZyBhcmd1bWVudHMKICB0YXJnZXQvaGV4YWdvbjogZml4IHNlbWlob3N0aW5n
IE9QRU4gZmlsZW5hbWUgaGFuZGxpbmcKICB0YXJnZXQvaGV4YWdvbjogZml4IHNlbWlob3N0aW5n
IFNUQVQgZmlsZW5hbWUgaGFuZGxpbmcKICB0YXJnZXQvaGV4YWdvbjogZml4IHNlbWlob3N0aW5n
IEFDQ0VTUyBmaWxlbmFtZSBoYW5kbGluZwoKIHRhcmdldC9oZXhhZ29uL2NwdV9oZWxwZXIuaCB8
ICAgMiAtCiB0YXJnZXQvaGV4YWdvbi9jcHVfaGVscGVyLmMgfCAgNDggKystLS0tLS0tLS0tLQog
dGFyZ2V0L2hleGFnb24vaGV4c3dpLmMgICAgIHwgMTM0ICsrKysrKysrKysrKysrKysrKysrKy0t
LS0tLS0tLS0tLS0tLQogMyBmaWxlcyBjaGFuZ2VkLCA4MiBpbnNlcnRpb25zKCspLCAxMDIgZGVs
ZXRpb25zKC0pCgotLSAKMi4zNC4xCgo=

