Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA1CEC98325
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 01:55:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9vAJ-0006Nx-TZ; Thu, 24 Sep 2026 21:55:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x9vAE-0005z6-A6
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 21:55:50 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x9vAC-0006Cj-D8
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 21:55:50 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68P1kUYq705969
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 01:55:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=huHHU9JPfrMmnGV7wzFDLn+fTXG4sjxg68tMkr67vfs=; b=ou
 +vlpWSjimS0j/KCXTlQAFEfH+/vgc1V9jiskV46GNQ2j2Ik0etqf/PuPo8jXOC/f
 B2RRwq/S0Fh82vVeL5U+VBNN+HJ9h9SHp4GJIJxXrL1kAAOWUsis4YmXDB4VJ81h
 NDGrCfrZ+vsk9E0OEzVCOHyQMnHRTcBK1yMOJ61+Yi5HWHLVEotnB0QbyFChsWMZ
 K2rOkmz9KxNudAzo8KvnahwpScc/gM1aq7LMTkKodD05jsauPGsQp0YM2obge3by
 WXgwa5Vz8eN7jfAcfnjcdjCJjDtuOuc7InQyweJqAjoUlXWUyJkQDku6qDkyOKd2
 imlkrWaNR6pmTKovp1BQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwce78hb9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 01:55:46 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-333543ac378so438535eec.1
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 18:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790301346; x=1790906146; darn=nongnu.org;
 h=content-transfer-encoding:content-type:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=huHHU9JPfrMmnGV7wzFDLn+fTXG4sjxg68tMkr67vfs=;
 b=hsQ5zQ+gBxTB4QKMgAASB8KRNOxzDrzPeUkwdQmVXmrdzmro5cAvAhDDNMPD//Lppd
 SWX7CW+Nvy/SOMUHZ4ZQtulmFhLjkM4h/DRpYGfAkWZ356/7wbgybmOr3sgPzCijQwbl
 tpdW0kysKliRzsiew6UJsY7EPm/a2Hm7rK1cw7igWB1NcII1KXzY6ilKSTJQ/oxGsPqo
 n0OrmXRqKYpy/tuWtyE9qXV+4pev4Ou3LK0HCTTVc34TX6MJc4qzunB3NhQ11/d+DE3d
 HOuhpEmh7pKoz3giMZYboWKnCnbwuCDNhzFZDZTLkcXP6vq0dD//1Fi4dT21klLi/que
 sJGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790301346; x=1790906146;
 h=content-transfer-encoding:content-type:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=huHHU9JPfrMmnGV7wzFDLn+fTXG4sjxg68tMkr67vfs=;
 b=XcjAYCDbuxkliU6wz5t0xO8S3jw+1vwOI4y8FopPsrY9YN43P9VJHHwgQITPhrbpn+
 o1LgH4oZ7YWfoupAcx7enzC3LXYZPhtUNy566OBp3lrX5iMFZGTciQCoQ2Sa12OeQ9nh
 x/zviLvH2TeJOsxFuruOjNLHRmx3/ekbNED8q3F7cpZOOZP6uRO3oiZec4VmMFlA01bR
 XcYJzEPAgeJ8VQi31S5ntKh1X8dXlP4zyH+wa2OW2ee+1bsMh6feKTlKqqHOkfUzMrRt
 cWPHEIdQX3ZBhdOMYpIj6O9I8XFfCe2s80ao7g+8BcAN//LkljZYnH+YGuMHK5keGt2C
 9TKA==
X-Gm-Message-State: AFuF++nE298grs9Rst+N32EWBHZaA2IrvOhnIJk5RFYBHAVmE5vxRAXY
 zEmPj1GNEQPdqAKZxk5N+cXrVhwm3k0PlhBvjWLRWMtQuSVHFbLkehYLwfHs1gAQkzla7daIFcS
 i0qhYIPvT+HwNQYiU1DxSxBHM5flv9NjX8ouNZ8xIDcNud+O1z3MyKGhllXQ8T+IBzQ==
X-Gm-Gg: AYBFou1U70B+uh+7AkAGhKUu/E7j9abmYMLYNxwwLloxA8dkpGH2Ng9uBBfeCy35xbc
 k6SMcACx5jAr513B+gc+aMGbY76hpy1clgKKcoJteSbOHX7IKBDagaUz17+40HSyzZuD1chZ/C4
 zWdcnXEE4GRy2RnOFvVMmTnjq2Y4BfBBmPlME0rHZ9anlEYjZ1ItXd5fwSPmu3D2yzk1oT6WksP
 tcPBAZmzIjbkqp6BmnA6a6P2kBpRHaPR43ThPNXkNcUHk9jYM0uMUIaFrLvupI14+cBl5fpo7p1
 1E4uHGKI3/qSfgUGqtiMCUlJytcBfXUxKqzAZDg8yYSbaEOqLDivshqDMQ3V/0iqJwVPfsRhrHK
 BT5i85OSIW+bi2mz5Z27v4n+XCdm+MkesAS4NmjhkNc3EzyU=
X-Received: by 2002:a05:7300:7a0c:b0:33b:5b1b:134c with SMTP id
 5a478bee46e88-3400566b548mr3410883eec.38.1790301346153; 
 Thu, 24 Sep 2026 18:55:46 -0700 (PDT)
X-Received: by 2002:a05:7300:7a0c:b0:33b:5b1b:134c with SMTP id
 5a478bee46e88-3400566b548mr3410863eec.38.1790301345543; 
 Thu, 24 Sep 2026 18:55:45 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3416e4c2f50sm1873720eec.27.2026.09.24.18.55.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 18:55:43 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 38/40] target/hexagon: fix HVX predicate save size for
 histogram ops
Date: Thu, 24 Sep 2026 18:54:27 -0700
Message-Id: <20260925015429.2579174-39-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260925015429.2579174-1-brian.cain@oss.qualcomm.com>
References: <20260925015429.2579174-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: QHqNMMlE3SL9zuDyGajygaMmRFI7PUXc
X-Proofpoint-ORIG-GUID: QHqNMMlE3SL9zuDyGajygaMmRFI7PUXc
X-Authority-Analysis: v=2.4 cv=NJFAaE6g c=1 sm=1 tr=0 ts=6ab5d4a2 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=iBrAFeRkQMIbT85dZ3EA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAwNyBTYWx0ZWRfX95JLUUwl3hon
 1OrkzJ1IjslK1vZa6WYYX1zsWG5UqlL0rt44vESE2MFQ/NflS+bVI74ZEgg/pJoBZxTSTlSmTRo
 NkB0FK0UzpNDL9+JDiyZpKZ8bLWiBzBqS8qHJPrQMCRJwI38EHSUNiPccYDVlZDMNXcYKOSYJRp
 fkWTK+BE72z834c4hDbXC7ZADyWAqU8Qn1isfbFnnTY1L6PyvS3luRPA8Qy7rRnY+bflTeMjLIK
 4/M7WJ9gW41CN8hrYIJangfAt11DET+ukuKB+efNDindirZXMthgJbOlLcTX5Y9QoA0ajIVGiU4
 CctMsS1ON+rTGNHkkyx51fjOyNfGHP1DgkhDNn5qvERpT6hOs6/U7CIim1zMqfNLQv4KGTmfevx
 AU8V3dNjUBrZVOTGSJ3nZXOGNeH3Bhrpbq9H9hupcT3LEnHUopV76jkTqNib0fqOTMqEXtPdQpf
 v/00tw1kfXC4R8l94Dw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAwNyBTYWx0ZWRfXydsgtzVqhjGH
 uiRd4GHxfaCn6jE3DC8RnURp9F/yXLKFcbBn46BsMPux4D34MUMeFdueWSL32goYOHcZLPlLxHH
 dQVciyM4MVLBqosy0twLUdAUxRQHe/k=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 spamscore=0
 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250007
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

VGhlIG1hc2tlZCBoaXN0b2dyYW0gaW5zdHJ1Y3Rpb25zIHNhdmUgdGhlIHByZWRpY2F0ZSBvcGVy
YW5kIHRvIHRoZSBxdG1wCnRlbXBvcmFyeSB3aXRoIGEgZ3ZlYyBtb3ZlIHNpemVkIHNpemVvZihN
TVZlY3RvcikuIEJvdGggc291cmNlIGFuZApkZXN0aW5hdGlvbiBhcmUgTU1RUmVnLCB3aGljaCBp
cyBlaWdodCB0aW1lcyBzbWFsbGVyLCBzbyB0aGUgbW92ZSByZWFkCjExMiBieXRlcyBwYXN0IHRo
ZSBwcmVkaWNhdGUgcmVnaXN0ZXIgYW5kIHdyb3RlIHRoZW0gb3ZlciB0aGUgZmllbGRzCmZvbGxv
d2luZyBxdG1wIGluIENQVUhleGFnb25TdGF0ZSwgdGhhdCBpcyB2c3RvcmVbMF0uIFVzZSB0aGUg
c2l6ZSBvZgp0aGUgcmVnaXN0ZXJzIGFjdHVhbGx5IGJlaW5nIGNvcGllZC4KCkZpeGVzOiA3YmE3
NjU3YmM5MyAoIkhleGFnb24gSFZYIGhlbHBlciBvdmVycmlkZXMgZm9yIGhpc3RvZ3JhbSAgaW5z
dHJ1Y3Rpb25zIikKUmV2aWV3ZWQtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRA
b3NzLnF1YWxjb21tLmNvbT4KUmV2aWV3ZWQtYnk6IE1hdGhldXMgVGF2YXJlcyBCZXJuYXJkaW5v
IDxtYXRoZXVzLmJlcm5hcmRpbm9Ab3NzLnF1YWxjb21tLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJp
YW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29u
L2dlbl90Y2dfaHZ4LmggfCAxMCArKysrKy0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRp
b25zKCspLCA1IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2dlbl90
Y2dfaHZ4LmggYi90YXJnZXQvaGV4YWdvbi9nZW5fdGNnX2h2eC5oCmluZGV4IGYzOTkyOTFkYzY2
Li41NDhiNDliNDE1NiAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vZ2VuX3RjZ19odnguaAor
KysgYi90YXJnZXQvaGV4YWdvbi9nZW5fdGNnX2h2eC5oCkBAIC01MCw3ICs1MCw3IEBAIHN0YXRp
YyBpbmxpbmUgdm9pZCBhc3NlcnRfdmhpc3RfdG1wKERpc2FzQ29udGV4dCAqY3R4KQogICAgICAg
ICBpZiAoY3R4LT5wcmVfY29tbWl0KSB7IFwKICAgICAgICAgICAgIGludHB0cl90IGRzdG9mZiA9
IG9mZnNldG9mKENQVUhleGFnb25TdGF0ZSwgcXRtcCk7IFwKICAgICAgICAgICAgIHRjZ19nZW5f
Z3ZlY19tb3ZfdmFyKE1PXzY0LCB0Y2dfZW52LCBkc3RvZmYsIFF2Vl9iYXNlLCBRdlZfb2ZmLCBc
Ci0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzaXplb2YoTU1WZWN0b3IpLCBzaXpl
b2YoTU1WZWN0b3IpKTsgXAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc2l6ZW9m
KE1NUVJlZyksIHNpemVvZihNTVFSZWcpKTsgXAogICAgICAgICB9IGVsc2UgeyBcCiAgICAgICAg
ICAgICBhc3NlcnRfdmhpc3RfdG1wKGN0eCk7IFwKICAgICAgICAgICAgIGdlbl9oZWxwZXJfdmhp
c3RxKHRjZ19lbnYpOyBcCkBAIC02Niw3ICs2Niw3IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBhc3Nl
cnRfdmhpc3RfdG1wKERpc2FzQ29udGV4dCAqY3R4KQogICAgICAgICBpZiAoY3R4LT5wcmVfY29t
bWl0KSB7IFwKICAgICAgICAgICAgIGludHB0cl90IGRzdG9mZiA9IG9mZnNldG9mKENQVUhleGFn
b25TdGF0ZSwgcXRtcCk7IFwKICAgICAgICAgICAgIHRjZ19nZW5fZ3ZlY19tb3ZfdmFyKE1PXzY0
LCB0Y2dfZW52LCBkc3RvZmYsIFF2Vl9iYXNlLCBRdlZfb2ZmLCBcCi0gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBzaXplb2YoTU1WZWN0b3IpLCBzaXplb2YoTU1WZWN0b3IpKTsgXAor
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc2l6ZW9mKE1NUVJlZyksIHNpemVvZihN
TVFSZWcpKTsgXAogICAgICAgICB9IGVsc2UgeyBcCiAgICAgICAgICAgICBhc3NlcnRfdmhpc3Rf
dG1wKGN0eCk7IFwKICAgICAgICAgICAgIGdlbl9oZWxwZXJfdndoaXN0MjU2cSh0Y2dfZW52KTsg
XApAQCAtODIsNyArODIsNyBAQCBzdGF0aWMgaW5saW5lIHZvaWQgYXNzZXJ0X3ZoaXN0X3RtcChE
aXNhc0NvbnRleHQgKmN0eCkKICAgICAgICAgaWYgKGN0eC0+cHJlX2NvbW1pdCkgeyBcCiAgICAg
ICAgICAgICBpbnRwdHJfdCBkc3RvZmYgPSBvZmZzZXRvZihDUFVIZXhhZ29uU3RhdGUsIHF0bXAp
OyBcCiAgICAgICAgICAgICB0Y2dfZ2VuX2d2ZWNfbW92X3ZhcihNT182NCwgdGNnX2VudiwgZHN0
b2ZmLCBRdlZfYmFzZSwgUXZWX29mZiwgXAotICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgc2l6ZW9mKE1NVmVjdG9yKSwgc2l6ZW9mKE1NVmVjdG9yKSk7IFwKKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHNpemVvZihNTVFSZWcpLCBzaXplb2YoTU1RUmVnKSk7IFwKICAg
ICAgICAgfSBlbHNlIHsgXAogICAgICAgICAgICAgYXNzZXJ0X3ZoaXN0X3RtcChjdHgpOyBcCiAg
ICAgICAgICAgICBnZW5faGVscGVyX3Z3aGlzdDI1NnFfc2F0KHRjZ19lbnYpOyBcCkBAIC05OCw3
ICs5OCw3IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBhc3NlcnRfdmhpc3RfdG1wKERpc2FzQ29udGV4
dCAqY3R4KQogICAgICAgICBpZiAoY3R4LT5wcmVfY29tbWl0KSB7IFwKICAgICAgICAgICAgIGlu
dHB0cl90IGRzdG9mZiA9IG9mZnNldG9mKENQVUhleGFnb25TdGF0ZSwgcXRtcCk7IFwKICAgICAg
ICAgICAgIHRjZ19nZW5fZ3ZlY19tb3ZfdmFyKE1PXzY0LCB0Y2dfZW52LCBkc3RvZmYsIFF2Vl9i
YXNlLCBRdlZfb2ZmLCBcCi0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzaXplb2Yo
TU1WZWN0b3IpLCBzaXplb2YoTU1WZWN0b3IpKTsgXAorICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgc2l6ZW9mKE1NUVJlZyksIHNpemVvZihNTVFSZWcpKTsgXAogICAgICAgICB9IGVs
c2UgeyBcCiAgICAgICAgICAgICBhc3NlcnRfdmhpc3RfdG1wKGN0eCk7IFwKICAgICAgICAgICAg
IGdlbl9oZWxwZXJfdndoaXN0MTI4cSh0Y2dfZW52KTsgXApAQCAtMTE1LDcgKzExNSw3IEBAIHN0
YXRpYyBpbmxpbmUgdm9pZCBhc3NlcnRfdmhpc3RfdG1wKERpc2FzQ29udGV4dCAqY3R4KQogICAg
ICAgICBpZiAoY3R4LT5wcmVfY29tbWl0KSB7IFwKICAgICAgICAgICAgIGludHB0cl90IGRzdG9m
ZiA9IG9mZnNldG9mKENQVUhleGFnb25TdGF0ZSwgcXRtcCk7IFwKICAgICAgICAgICAgIHRjZ19n
ZW5fZ3ZlY19tb3ZfdmFyKE1PXzY0LCB0Y2dfZW52LCBkc3RvZmYsIFF2Vl9iYXNlLCBRdlZfb2Zm
LCBcCi0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzaXplb2YoTU1WZWN0b3IpLCBz
aXplb2YoTU1WZWN0b3IpKTsgXAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc2l6
ZW9mKE1NUVJlZyksIHNpemVvZihNTVFSZWcpKTsgXAogICAgICAgICB9IGVsc2UgeyBcCiAgICAg
ICAgICAgICBUQ0d2IHRjZ3ZfdWlWID0gdGNnX2NvbnN0YW50X3RsKHVpVik7IFwKICAgICAgICAg
ICAgIGFzc2VydF92aGlzdF90bXAoY3R4KTsgXAotLSAKMi4zNC4xCgo=

