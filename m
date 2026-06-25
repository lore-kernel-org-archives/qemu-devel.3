Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F9C2CDB479
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 14:17:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcktZ-0006tY-38; Thu, 25 Jun 2026 10:17:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wcktV-0006sE-6k
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:17:29 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wcktT-0008Vm-Il
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:17:28 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65P9juso1470528
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:17:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=iyq7LBA9ReIYZhusAxIzcfXUYATt4rc1w494jGlIN/c=; b=Ee
 kQLoup9VsZlC75MdSSS2E8xx23lB8/V/5emjgivFwXSCF3LJSGiIjPraAf5I2trH
 i8EA0QhZS5bpcfzpfAXju+WHRhIloB7fUrsqj//a6YYffk7xcqttQ9/Do/KxuWS3
 lqOmxqCxpBqzfZ1oRCMroZ8U6tEgsj88pufXneFZMBrRuUTfTU5SZ2ksS/CzLNnS
 FGCaV7k7WrGAgpQ6MaKV2GK/JK5c95JRXTOtopKN6tMpfMsn2AMsC4ij9cQAEgOv
 X19FpTqmjMSd1lH8xmKhQVtmsbxkilZSZQ9S5xczs3c6vNJLlTjdVSTUphlodbCH
 0XAE2U2NEk1IDRjNhiBg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0nv7kp2w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:17:25 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30c8d355dbcso1439296eec.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 07:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782397045; x=1783001845; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iyq7LBA9ReIYZhusAxIzcfXUYATt4rc1w494jGlIN/c=;
 b=Nr2K39L+z1+c+NS00p2vkTuV8lQzY9haBh4ARKnXTX36bJci/fa3Eu8Yuoia8agYz7
 /e7htIC1VYoddATd+wfrX+Zk9zZByjzKBm3q4Fea4dZsBfRUU4HdAHe7xVl942ZQG8iQ
 e2GLKrEl6Sv1wAZ5PTwUipOl1XQMnjpwYFAQSSDcnmNq2egKkm/bplckVqd56Z8SISZp
 YIWOTHzdC3G8M2aue+9ZTIyNISbovTDBpL+ZqH1GvSumvJodGR3uqGvT28sFzBES4+WQ
 VKESAIHsXkq598yRt3dmVlESLHpqE6l//uwC/kmpDgfw3iPsGcLZItr+xTUCKPLE7Oz3
 QH/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782397045; x=1783001845;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iyq7LBA9ReIYZhusAxIzcfXUYATt4rc1w494jGlIN/c=;
 b=FNrXLVjVV3qzjvg8Xv/jLfC1iUO3p7SJwcKFd00hdcAFiEjSLR/GBHFQw/+6qeNp72
 RdH7TOsc1+sIxiLj1d5ZlNvv/f14LHBy1DvmZzBqGCd4OPySf+ZE1pdoOQKjuY88TN8d
 RBg1DGjUYmg9gij9GjU4r9Q2oZvzPuMtAXkVcwCxA6HGqbHj2pyBCK/1IuLAROT9mQ0h
 Cwn6pUsbryP0SOT7Cg01Wm0L4ryfYeldALvj1PH/Q4BlVxiWJT40ttRuOBc8mwZJk9Mr
 WOD4FztbI/gRhwXb2Gpp/oSn6YlemoMZC399Oen9Qj05/nouu4oJxzFk5MS27+zeHPCi
 NQsg==
X-Gm-Message-State: AOJu0Ywte8l6xkYh6JfkOjvZESuKLr+m9NhwvxReXgCUCgi6Is1qj1H4
 Nf9VbyUjZgk0hWL3QQmMwnIPRc6jiOx3BmQzxPNSNXfyHc6WUlfqJvJlP/uzmif2tgnBPyLB9y1
 4heIyguQypzZfl2ksmTcYYgOhgwlg9/DEQgDzzHSXOuI1GaNXc72ezyxzGaKl3R6z+w==
X-Gm-Gg: AfdE7ckRdJ/lOYxWPeTq0/da4AUKx3TPKcxFRUqNHzNMpChV4W+mk53GKTzmsLn2QJg
 m2G1k4n+aWWWmBDcYWw125kFkxzTE09RKTw7FHfv/CcRnRgOGHuO00a0/KgBI7I6PFXO/JU/h2u
 MXn7xjVaa63OrkHVu/4MhIU+4uxHhJzADws6zfAZYlful1DkyNCHswUAW2R50V5/g2xJblBCMFb
 4vlraUfSVkCajdENycEqZ6n+nDC3RJmkegO3YcoxeZ/SLPAtEeWjL0sUh/JyO9vqxicEQSM2V0Y
 ojTVB0JPVAt0UsKLv/oF92DdFB0LKD4f79eLmOHFQAmepd+lTOVQgdS7DmZkn+l4h1bndZ2yxCs
 pHVQtR8Qj3XPQH1kQDONB+N5mGjiuOSYclRFfA8Aopy40Mm6ukZbEJ3C+vUg=
X-Received: by 2002:a05:7301:9bcb:b0:2e7:c701:aa85 with SMTP id
 5a478bee46e88-30c84d1063cmr3971536eec.17.1782397045016; 
 Thu, 25 Jun 2026 07:17:25 -0700 (PDT)
X-Received: by 2002:a05:7301:9bcb:b0:2e7:c701:aa85 with SMTP id
 5a478bee46e88-30c84d1063cmr3971450eec.17.1782397044238; 
 Thu, 25 Jun 2026 07:17:24 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c8b1ae5sm10168446eec.16.2026.06.25.07.17.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 07:17:23 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v3 24/76] target/hexagon: Implement do_raise_exception()
Date: Thu, 25 Jun 2026 07:15:41 -0700
Message-Id: <20260625141633.449487-25-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
References: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDEyMiBTYWx0ZWRfXxXrXKAXns4qK
 airYVL5+2KvIef0qO4/5w4xIlAN3GD5KP4ouiksZIwDpPXUFMBbl+TM1goLhdblFUQiKCblVpMB
 VkeMuASeoUYToe0viS+401wjF1jB7tg=
X-Authority-Analysis: v=2.4 cv=RJiD2Yi+ c=1 sm=1 tr=0 ts=6a3d3875 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=hK29HtBGQMdOITfcgGsA:9 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: rRqVdZv2H18pA0rKCWZQNaiApfRrej_U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDEyMiBTYWx0ZWRfX+D5aLjGFGOLP
 1bEdsIQaooZTTjdf9eeLYOPFRBGLRBSmq4R7OZyEa3aqSFeTIjRs4M0V0/iqd5BiqM4T9KOC1Mu
 7bh1yFvMUSP0mQW+By0Wl+1cIhlYsz/K6kds4Tmxf9mzIhvZ1zd3+YhMETEs/9vD5VRIh+WOZbU
 fkBzqDhOAv/KdwmJPtZey7DMYzQQtxCQ2nHv886uLdAtlxyPT5OdXNe0xjcz8r6XlCo5J57VnpP
 26CTQQkVri7Lcln/u3zSLubJInK/yYttoIWOTLnHiOyaMCdM7gklw87s+ygicwLoMMhEy/B3Lcd
 pbnHWtLAOXj4IeOltpExtvgU/LtaVSK48eMqLHyjmJKnxv1jsj7L+VSHfpZH+2JNsGpoyq84rsT
 XtSdFet4zl+fAHnafRZkON4yucB0AAzmM2L6CJ8TzzeBUiL5toLDjtCbAFjWir+n3JbuQ2OVo5O
 zYHh6fK1ukp/Ce/gRHw==
X-Proofpoint-GUID: rRqVdZv2H18pA0rKCWZQNaiApfRrej_U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250122
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KUmV2aWV3ZWQtYnk6IFBoaWxpcHBl
IE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2lu
dGVybmFsLmggIHwgIDUgKysrKysKIHRhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jIHwgMTQgKysr
KysrKysrKysrKysKIDIgZmlsZXMgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdp
dCBhL3RhcmdldC9oZXhhZ29uL2ludGVybmFsLmggYi90YXJnZXQvaGV4YWdvbi9pbnRlcm5hbC5o
CmluZGV4IGNkMDZmZjQxZDRmLi4zM2Q3M2VkMThkMSAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFn
b24vaW50ZXJuYWwuaAorKysgYi90YXJnZXQvaGV4YWdvbi9pbnRlcm5hbC5oCkBAIC0zMSw2ICsz
MSwxMSBAQCB2b2lkIGhleGFnb25fZGVidWcoQ1BVSGV4YWdvblN0YXRlICplbnYpOwogCiBleHRl
cm4gY29uc3QgY2hhciAqIGNvbnN0IGhleGFnb25fcmVnbmFtZXNbVE9UQUxfUEVSX1RIUkVBRF9S
RUdTXTsKIAordm9pZCBHX05PUkVUVVJOIGRvX3JhaXNlX2V4Y2VwdGlvbihDUFVIZXhhZ29uU3Rh
dGUgKmVudiwKKyAgICAgICAgdWludDMyX3QgZXhjZXB0aW9uLAorICAgICAgICB1aW50MzJfdCBQ
QywKKyAgICAgICAgdWludHB0cl90IHJldGFkZHIpOworCiAjaWZuZGVmIENPTkZJR19VU0VSX09O
TFkKIGV4dGVybiBjb25zdCBWTVN0YXRlRGVzY3JpcHRpb24gdm1zdGF0ZV9oZXhhZ29uX2NwdTsK
ICNlbmRpZgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMgYi90YXJnZXQv
aGV4YWdvbi9vcF9oZWxwZXIuYwppbmRleCBjZDMyNGMxOWE5ZC4uMGY0M2E2NjYzNDEgMTAwNjQ0
Ci0tLSBhL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jCisrKyBiL3RhcmdldC9oZXhhZ29uL29w
X2hlbHBlci5jCkBAIC00MSw2ICs0MSwyMCBAQAogI2RlZmluZSBTRl9NQU5UQklUUyAgICAyMwog
CiAvKiBFeGNlcHRpb25zIHByb2Nlc3NpbmcgaGVscGVycyAqLworR19OT1JFVFVSTgordm9pZCBk
b19yYWlzZV9leGNlcHRpb24oQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IGV4Y2VwdGlv
biwKKyAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90IFBDLCB1aW50cHRyX3QgcmV0YWRk
cikKK3sKKyAgICBDUFVTdGF0ZSAqY3MgPSBlbnZfY3B1KGVudik7CisgICAgcWVtdV9sb2dfbWFz
ayhDUFVfTE9HX0lOVCwgIiVzOiAweCUwOCIgUFJJeDMyICIsIEAgJTA4IiBQUkl4MzIgIlxuIiwK
KyAgICAgICAgICAgICAgICAgIF9fZnVuY19fLCBleGNlcHRpb24sIFBDKTsKKyAgICBBU1NFUlRf
RElSRUNUX1RPX0dVRVNUX1VOU0VUKGVudiwgZXhjZXB0aW9uKTsKKworICAgIGVudi0+Z3ByW0hF
WF9SRUdfUENdID0gUEM7CisgICAgY3MtPmV4Y2VwdGlvbl9pbmRleCA9IGV4Y2VwdGlvbjsKKyAg
ICBjcHVfbG9vcF9leGl0X3Jlc3RvcmUoY3MsIHJldGFkZHIpOworfQorCiBHX05PUkVUVVJOIHZv
aWQgaGV4YWdvbl9yYWlzZV9leGNlcHRpb25fZXJyKENQVUhleGFnb25TdGF0ZSAqZW52LAogICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50MzJfdCBleGNlcHRp
b24sCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnRwdHJf
dCBwYykKLS0gCjIuMzQuMQoK

