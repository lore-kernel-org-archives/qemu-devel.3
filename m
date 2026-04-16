Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EE06F433D0
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 21:04:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDTsB-00008r-Ch; Thu, 16 Apr 2026 17:03:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wDTs1-0008Ub-4G
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 17:03:30 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wDTry-0000zf-5f
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 17:03:28 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63GIRQRR1183760
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 21:03:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vGTOuwwdCbFJxmkP8mrt/qBNjb/dMJD/0dO3u17IN84=; b=ifY3Lq8/wR71LTsb
 IOLAjQd7pK7RnYtqGqfwosogagEuZxZE2UrGoveIJwRreR0bioQlYjekPt+bV1oi
 0f3PtkT1f9NInkm2UEm16bmWegiX31QlOJtVYX7WEN/iJV5l2xevdYyl599qdol3
 QzSJTNwDFFLApYmXT6Uw79wMiV0KgIuydZzY2iNuOea8rCxoJL4nsoT62g668vlH
 cPlGQaL25vuY15MWBz3E2c7hEKqGcifUV54v96GmGWFVhQ9sW7WdFX4mrXSr6iWv
 SeRe2zPqaZ7dMyrZ1v0Hhnlzg5TKLPtWS2V6tUcURKUsmMleY3MFAM+AoAi14Yqw
 /O63vA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dk52jgfec-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 21:03:24 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2da19227bc1so19585935eec.1
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 14:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776373404; x=1776978204; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vGTOuwwdCbFJxmkP8mrt/qBNjb/dMJD/0dO3u17IN84=;
 b=fnnklLLtczpWoet+kA2Au3AA5S3OQepQD56tlq9CZYxpg5qTgapzbvtiGDU35WFiWX
 muoG7Avd1l9tFHKHOCBhRAVYTr1PJnSVBEbUGg7V/4N2XTbza0R3CRtMdx6bux+HSLH9
 Zee792rE5fToinUQAxdtysya3eGU7pwfpo8sDx6dfBCWwQNNaMeTlfomur5LE/YpOg3I
 34qAosMZ0H26CI6kJ2wTK2n7WMM08HtcSRCw5PcZsbdpW0C2jnoIkuWinjpRZp2gbIeT
 HcjxQbBOos0zaA/zu6qEX6VgpIJ1LfLGuthGSpHKnJHi+/dQM0viRli8aszSpzXddjxy
 FjjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776373404; x=1776978204;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vGTOuwwdCbFJxmkP8mrt/qBNjb/dMJD/0dO3u17IN84=;
 b=sq/CmwPPbHAg77vzCnf7Nbc0YtxL11ezJaO3L/n4HdQBngf3SvQS+E6fnwwTh7t9tp
 Xk9NYJcE3UJHtYsUIVMlnqqDh64a9aDN9FFob/CqiFUJDus3Flc76fIkrmOTn5ChmMfh
 bWJdJ7bq3eTeje6mqBq6Zd07yvuQ7wdd+FkgkbOaRaJ2mNRTuXxBqZQH0RKImNNxJCdm
 hbVDx/tckPs/8AXmE0I3ewerqCGBG9DFMFz3XuCHglO2N6bM9/4WrkBQ9zsziWqmFFq4
 dCzKqyRv/zNaHtmy3LyH6cx42KW3oc+W5umRMJ4fWzTL1URrMKOWvIzdnYgS9cVu+R4D
 fBng==
X-Gm-Message-State: AOJu0Yyk6lNouZcC/3nGt60lBlwdyKCnDaNM82soH9KbxoipUzHx9eY2
 5svAD5AH6WvjHqzceYFri4LzJ58jTFBo5PIJn2v1kho+9s14XD6apUihVXg84G4lnilXKAMA+YX
 oLtMiwRkRuqwVV+E+9mjeA0lKzFHnoigNVgs2UznJsxTL7fvrUnmxFlJ/pn8ZXGNisA==
X-Gm-Gg: AeBDievZDxdAulxL1JLY4SZK4wFZ4nHcYn+wxMpL7ujbpm4BHqzh/uZul8KiNUNtVZl
 bVVSupmUFken+71Gy/1mSGHnMRfnBCP2W8K+W6TQftFER9xnE7ynKe8sa+wI22xqQTNmDql1tQ2
 5fagwy+VxKOFrsGy9WjiH5HucZzMjZP4W4bU8R6tXaT6VJ2RTwBFGZdU86CcvjINaC1FTLbGgXj
 EMDQe26tjbBqMFMJ7rsr8JastbTdm4s5zDcq492LrCklXpnuONHvHHeBn0vl5ah9jROb7vdTwet
 UFX55xjXptg2wUqwpkKhjH4SpU6fYqH4HmTrCWOL7PEuJa3eZ1elqPIK4Hyg3a/XN909SfqsV+H
 LHYIKF6dXwW2PF3vGIaJbJnuPzXU2uxx8ej6CvX72tROHeKeaPt+AiAbIkN7FRTjMVBB7PXFokv
 etQpzo
X-Received: by 2002:a05:7300:ed18:b0:2da:b77a:d7a0 with SMTP id
 5a478bee46e88-2e2e3e68808mr535334eec.9.1776373403702; 
 Thu, 16 Apr 2026 14:03:23 -0700 (PDT)
X-Received: by 2002:a05:7300:ed18:b0:2da:b77a:d7a0 with SMTP id
 5a478bee46e88-2e2e3e68808mr535311eec.9.1776373403088; 
 Thu, 16 Apr 2026 14:03:23 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2de8c90cd7esm11176277eec.13.2026.04.16.14.03.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 14:03:22 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, pierrick.bouvier@oss.qualcomm.com,
 Brian Cain <bcain@quicinc.com>
Subject: [PATCH v5 4/9] hw/hexagon: Add v68, sa8775-cdsp0 defs
Date: Thu, 16 Apr 2026 14:03:00 -0700
Message-Id: <20260416210305.2255579-5-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260416210305.2255579-1-brian.cain@oss.qualcomm.com>
References: <20260416210305.2255579-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=buR8wkai c=1 sm=1 tr=0 ts=69e14e9c cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=Y0VZbjsYLljPqHOwCnMA:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: r718YIvqiH0bDL2ddeEdg5nEErpMA9NQ
X-Proofpoint-ORIG-GUID: r718YIvqiH0bDL2ddeEdg5nEErpMA9NQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDE5OSBTYWx0ZWRfXz2eT3Eziv+ii
 IeagWYi4bvh0eVZqit3rBgHyzx92MdD6odHeNeBiA6GNbAqVWeimfsp2uSTNossZoaebkyTdmWf
 prLkHsvU17vwuJv8nayUSp3h0OSzJBuV85pxERjl+i511na41N0bxfMzSR4oyvuxwtc1RSF8gkB
 OheXNHU44EKQInTlskEROxIrjUaNRZ1WgxdJWHV+9tVxCiFJmi2tSVnsaTCyg7bVFo7ppFm8rvV
 iS/Trr8/6whyif0JenhYu8ELiAeOk+VHwVTmNhuYDqprY1gscwDYEMcJIdb4TcjM1bOfmRjZlOP
 d/N0vVu2LvtIBzbjQj3sOdI/DwdlHswYUduVrMHSHXEjlIn7Qv1ifHgBFRkoOuGVzYG3auJF4FZ
 1IVT2n6rXEAj9Qq3eB9deSzBnt4sY380Lpcy1LE3TidMN25+eQbCEEmb6r7eaVEYt3wV2n6YCet
 MRVb9eh1FlfizHUURJw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160199
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpBY2tlZC1ieTogVGF5bG9yIFNp
bXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2Fp
biA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIGh3L2hleGFnb24vbWFjaGluZV9j
Zmdfc2E4Nzc1X2Nkc3AwLmguaW5jIHwgNjQgKysrKysrKysrKysrKysrKysrKysrKwogaHcvaGV4
YWdvbi9tYWNoaW5lX2NmZ192NjhuXzEwMjQuaC5pbmMgICAgfCA2NSArKysrKysrKysrKysrKysr
KysrKysrKwogMiBmaWxlcyBjaGFuZ2VkLCAxMjkgaW5zZXJ0aW9ucygrKQogY3JlYXRlIG1vZGUg
MTAwNjQ0IGh3L2hleGFnb24vbWFjaGluZV9jZmdfc2E4Nzc1X2Nkc3AwLmguaW5jCiBjcmVhdGUg
bW9kZSAxMDA2NDQgaHcvaGV4YWdvbi9tYWNoaW5lX2NmZ192NjhuXzEwMjQuaC5pbmMKCmRpZmYg
LS1naXQgYS9ody9oZXhhZ29uL21hY2hpbmVfY2ZnX3NhODc3NV9jZHNwMC5oLmluYyBiL2h3L2hl
eGFnb24vbWFjaGluZV9jZmdfc2E4Nzc1X2Nkc3AwLmguaW5jCm5ldyBmaWxlIG1vZGUgMTAwNjQ0
CmluZGV4IDAwMDAwMDAwMDAwLi40NDJjYmUzYmUzMQotLS0gL2Rldi9udWxsCisrKyBiL2h3L2hl
eGFnb24vbWFjaGluZV9jZmdfc2E4Nzc1X2Nkc3AwLmguaW5jCkBAIC0wLDAgKzEsNjQgQEAKKy8q
IFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyICovCisKK3N0YXRpYyBj
b25zdCBzdHJ1Y3QgaGV4YWdvbl9tYWNoaW5lX2NvbmZpZyBTQTg3NzVQX2Nkc3AwID0geworICAg
IC5jZmdiYXNlID0gICAgICAgICAweDI0MDAwMDAwICsgMHgxODAwMDAsCisgICAgLmwydGNtX3Np
emUgPSAgICAgIDB4MDAwMDAwMDAsCisgICAgLmwydmljX2Jhc2UgPSAgICAgIDB4MjYzMDAwMDAg
KyAweDkwMDAwLAorICAgIC5sMnZpY19zaXplID0gICAgICAweDAwMDAxMDAwLAorICAgIC5jc3Jf
YmFzZSA9ICAgICAgICAweDI2MzAwMDAwLAorICAgIC5xdG1yX3JlZ2lvbiA9ICAgICAweDI2MzAw
MDAwICsgMHhBMTAwMCwKKyAgICAuY2ZndGFibGUgPSB7CisgICAgICAgIC5sMnRjbV9iYXNlID0g
MHgwMDAwMjQwMCwKKyAgICAgICAgLnJlc2VydmVkMCA9IDB4MDAwMDAwMDAsCisgICAgICAgIC5z
dWJzeXN0ZW1fYmFzZSA9IDB4MDAwMDI2MzgsCisgICAgICAgIC5ldG1fYmFzZSA9IDB4MDAwMDI0
MTksCisgICAgICAgIC5sMmNmZ19iYXNlID0gMHgwMDAwMjQxYSwKKyAgICAgICAgLnJlc2VydmVk
MSA9IDB4MDAwMDI0MWIsCisgICAgICAgIC5sMXMwX2Jhc2UgPSAweDAwMDAyNTAwLAorICAgICAg
ICAuYXhpMl9sb3dhZGRyID0gMHgwMDAwMDAwMCwKKyAgICAgICAgLnN0cmVhbWVyX2Jhc2UgPSAw
eDAwMDAwMDAwLAorICAgICAgICAucmVzZXJ2ZWQyID0gMHgwMDAwMDAwMCwKKyAgICAgICAgLmZh
c3RsMnZpY19iYXNlID0gMHgwMDAwMjQxZSwKKyAgICAgICAgLmp0bGJfc2l6ZV9lbnRyaWVzID0g
MHgwMDAwMDA4MCwKKyAgICAgICAgLmNvcHJvY19wcmVzZW50ID0gMHgwMDAwMDAwMSwKKyAgICAg
ICAgLmV4dF9jb250ZXh0cyA9IDB4MDAwMDAwMDQsCisgICAgICAgIC52dGNtX2Jhc2UgPSAweDAw
MDAyNTAwLAorICAgICAgICAudnRjbV9zaXplX2tiID0gMHgwMDAwMjAwMCwKKyAgICAgICAgLmwy
dGFnX3NpemUgPSAweDAwMDAwNDAwLAorICAgICAgICAubDJlY29tZW1fc2l6ZSA9IDB4MDAwMDAw
MDAsCisgICAgICAgIC50aHJlYWRfZW5hYmxlX21hc2sgPSAweDAwMDAwMDNmLAorICAgICAgICAu
ZWNjcmVnX2Jhc2UgPSAweDAwMDAyNDFmLAorICAgICAgICAubDJsaW5lX3NpemUgPSAweDAwMDAw
MDgwLAorICAgICAgICAudGlueV9jb3JlID0gMHgwMDAwMDAwMCwKKyAgICAgICAgLmwyaXRjbV9z
aXplID0gMHgwMDAwMDAwMCwKKyAgICAgICAgLmwyaXRjbV9iYXNlID0gMHgwMDAwMjQwMCwKKyAg
ICAgICAgLnJlc2VydmVkMyA9IDB4MDAwMDAwMDAsCisgICAgICAgIC5kdG1fcHJlc2VudCA9IDB4
MDAwMDAwMDAsCisgICAgICAgIC5kbWFfdmVyc2lvbiA9IDB4MDAwMDAwMDMsCisgICAgICAgIC5o
dnhfdmVjX2xvZ19sZW5ndGggPSAweDAwMDAwMDA3LAorICAgICAgICAuY29yZV9pZCA9IDB4MDAw
MDAwMDAsCisgICAgICAgIC5jb3JlX2NvdW50ID0gMHgwMDAwMDAwMCwKKyAgICAgICAgLmNvcHJv
YzJfcmVnMCA9IDB4MDAwMDAwNDAsCisgICAgICAgIC5jb3Byb2MyX3JlZzEgPSAweDAwMDAwMDIw
LAorICAgICAgICAudjJ4X21vZGUgPSAweDAwMDAwMDAxLAorICAgICAgICAuY29wcm9jMl9yZWcy
ID0gMHgwMDAwMDAwOCwKKyAgICAgICAgLmNvcHJvYzJfcmVnMyA9IDB4MDAwMDAwMjAsCisgICAg
ICAgIC5jb3Byb2MyX3JlZzQgPSAweDAwMDAwMDAwLAorICAgICAgICAuY29wcm9jMl9yZWc1ID0g
MHgwMDAwMDAwMiwKKyAgICAgICAgLmNvcHJvYzJfcmVnNiA9IDB4MDAwMDAwMTYsCisgICAgICAg
IC5jb3Byb2MyX3JlZzcgPSAweDAwMDAwMDA2LAorICAgICAgICAuYWNkX3ByZXNldCA9IDB4MDAw
MDAwMDEsCisgICAgICAgIC5tbmRfcHJlc2V0ID0gMHgwMDAwMDAwMCwKKyAgICAgICAgLmwxZF9z
aXplX2tiID0gMHgwMDAwMDAxMCwKKyAgICAgICAgLmwxaV9zaXplX2tiID0gMHgwMDAwMDAyMCwK
KyAgICAgICAgLmwxZF93cml0ZV9wb2xpY3kgPSAweDAwMDAwMDAyLAorICAgICAgICAudnRjbV9i
YW5rX3dpZHRoID0gMHgwMDAwMDA4MCwKKyAgICAgICAgLnJlc2VydmVkNCA9IDB4MDAwMDAwMDEs
CisgICAgICAgIC5yZXNlcnZlZDUgPSAweDAwMDAwMDAwLAorICAgICAgICAucmVzZXJ2ZWQ2ID0g
MHgwMDAwMDAwMywKKyAgICAgICAgLmNvcHJvYzJfY3Z0X21weV9zaXplID0gMHgwMDAwMDAwYSwK
KyAgICAgICAgLmNvbnNpc3RlbmN5X2RvbWFpbiA9IDB4MDAwMDAwZTAsCisgICAgICAgIC5jYXBh
Y2l0eV9kb21haW4gPSAweDAwMDAwMDgwLAorICAgICAgICAuYXhpM19sb3dhZGRyID0gMHgwMDAw
MDAwMCwKKyAgICB9LAorfTsKZGlmZiAtLWdpdCBhL2h3L2hleGFnb24vbWFjaGluZV9jZmdfdjY4
bl8xMDI0LmguaW5jIGIvaHcvaGV4YWdvbi9tYWNoaW5lX2NmZ192NjhuXzEwMjQuaC5pbmMKbmV3
IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMDAwMDAuLjgyNjE5YzQyYWMxCi0tLSAvZGV2
L251bGwKKysrIGIvaHcvaGV4YWdvbi9tYWNoaW5lX2NmZ192NjhuXzEwMjQuaC5pbmMKQEAgLTAs
MCArMSw2NSBAQAorLyogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXIg
Ki8KKworc3RhdGljIGNvbnN0IHN0cnVjdCBoZXhhZ29uX21hY2hpbmVfY29uZmlnIHY2OG5fMTAy
NCA9IHsKKyAgICAuY2ZnYmFzZSA9ICAgICAgICAgICAweGRlMDAwMDAwLAorICAgIC5sMnRjbV9z
aXplID0gICAgICAgIDB4MDAwMDAwMDAsCisgICAgLmwydmljX2Jhc2UgPSAgICAgICAgMHhmYzkx
MDAwMCwKKyAgICAubDJ2aWNfc2l6ZSA9ICAgICAgICAweDAwMDAxMDAwLAorICAgIC5jc3JfYmFz
ZSA9ICAgICAgICAgIDB4ZmM5MDAwMDAsCisgICAgLnF0bXJfcmVnaW9uID0gICAgICAgMHhmYzky
MTAwMCwKKyAgICAuY2ZndGFibGUgPSB7CisgICAgICAgIC5sMnRjbV9iYXNlID0gMHgwMDAwZDgw
MCwKKyAgICAgICAgLnJlc2VydmVkMCA9IDB4MDAwMDAwMDAsCisgICAgICAgIC5zdWJzeXN0ZW1f
YmFzZSA9IDB4MDAwMGZjOTAsCisgICAgICAgIC5ldG1fYmFzZSA9IDB4MDAwMGQ4MTksCisgICAg
ICAgIC5sMmNmZ19iYXNlID0gMHgwMDAwZDgxYSwKKyAgICAgICAgLnJlc2VydmVkMSA9IDB4MDAw
MDAwMDAsCisgICAgICAgIC5sMXMwX2Jhc2UgPSAweDAwMDBkODQwLAorICAgICAgICAuYXhpMl9s
b3dhZGRyID0gMHgwMDAwMzAwMCwKKyAgICAgICAgLnN0cmVhbWVyX2Jhc2UgPSAweDAwMDBkODFj
LAorICAgICAgICAucmVzZXJ2ZWQyID0gMHgwMDAwZDgxZCwKKyAgICAgICAgLmZhc3RsMnZpY19i
YXNlID0gMHgwMDAwZDgxZSwKKyAgICAgICAgLmp0bGJfc2l6ZV9lbnRyaWVzID0gMHgwMDAwMDA4
MCwKKyAgICAgICAgLmNvcHJvY19wcmVzZW50ID0gMHgwMDAwMDAwMSwKKyAgICAgICAgLmV4dF9j
b250ZXh0cyA9IDB4MDAwMDAwMDQsCisgICAgICAgIC52dGNtX2Jhc2UgPSAweDAwMDBkODQwLAor
ICAgICAgICAudnRjbV9zaXplX2tiID0gMHgwMDAwMTAwMCwKKyAgICAgICAgLmwydGFnX3NpemUg
PSAweDAwMDAwNDAwLAorICAgICAgICAubDJlY29tZW1fc2l6ZSA9IDB4MDAwMDA0MDAsCisgICAg
ICAgIC50aHJlYWRfZW5hYmxlX21hc2sgPSAweDAwMDAwMDNmLAorICAgICAgICAuZWNjcmVnX2Jh
c2UgPSAweDAwMDBkODFmLAorICAgICAgICAubDJsaW5lX3NpemUgPSAweDAwMDAwMDgwLAorICAg
ICAgICAudGlueV9jb3JlID0gMHgwMDAwMDAwMCwKKyAgICAgICAgLmwyaXRjbV9zaXplID0gMHgw
MDAwMDAwMCwKKyAgICAgICAgLmwyaXRjbV9iYXNlID0gMHgwMDAwZDgyMCwKKyAgICAgICAgLnJl
c2VydmVkMyA9IDB4MDAwMDAwMDAsCisgICAgICAgIC5kdG1fcHJlc2VudCA9IDB4MDAwMDAwMDAs
CisgICAgICAgIC5kbWFfdmVyc2lvbiA9IDB4MDAwMDAwMDEsCisgICAgICAgIC5odnhfdmVjX2xv
Z19sZW5ndGggPSAweDAwMDAwMDA3LAorICAgICAgICAuY29yZV9pZCA9IDB4MDAwMDAwMDAsCisg
ICAgICAgIC5jb3JlX2NvdW50ID0gMHgwMDAwMDAwMCwKKyAgICAgICAgLmNvcHJvYzJfcmVnMCA9
IDB4MDAwMDAwNDAsCisgICAgICAgIC5jb3Byb2MyX3JlZzEgPSAweDAwMDAwMDIwLAorICAgICAg
ICAudjJ4X21vZGUgPSAweDFmMWYxZjFmLAorICAgICAgICAuY29wcm9jMl9yZWcyID0gMHgxZjFm
MWYxZiwKKyAgICAgICAgLmNvcHJvYzJfcmVnMyA9IDB4MWYxZjFmMWYsCisgICAgICAgIC5jb3By
b2MyX3JlZzQgPSAweDFmMWYxZjFmLAorICAgICAgICAuY29wcm9jMl9yZWc1ID0gMHgxZjFmMWYx
ZiwKKyAgICAgICAgLmNvcHJvYzJfcmVnNiA9IDB4MWYxZjFmMWYsCisgICAgICAgIC5jb3Byb2My
X3JlZzcgPSAweDFmMWYxZjFmLAorICAgICAgICAuYWNkX3ByZXNldCA9IDB4MWYxZjFmMWYsCisg
ICAgICAgIC5tbmRfcHJlc2V0ID0gMHgxZjFmMWYxZiwKKyAgICAgICAgLmwxZF9zaXplX2tiID0g
MHgxZjFmMWYxZiwKKyAgICAgICAgLmwxaV9zaXplX2tiID0gMHgxZjFmMWYxZiwKKyAgICAgICAg
LmwxZF93cml0ZV9wb2xpY3kgPSAweDFmMWYxZjFmLAorICAgICAgICAudnRjbV9iYW5rX3dpZHRo
ID0gMHgxZjFmMWYxZiwKKyAgICAgICAgLnJlc2VydmVkNCA9IDB4MWYxZjFmMWYsCisgICAgICAg
IC5yZXNlcnZlZDUgPSAweDFmMWYxZjFmLAorICAgICAgICAucmVzZXJ2ZWQ2ID0gMHgxZjFmMWYx
ZiwKKyAgICAgICAgLmNvcHJvYzJfY3Z0X21weV9zaXplID0gMHgxZjFmMWYxZiwKKyAgICAgICAg
LmNvbnNpc3RlbmN5X2RvbWFpbiA9IDB4MWYxZjFmMWYsCisgICAgICAgIC5jYXBhY2l0eV9kb21h
aW4gPSAweDFmMWYxZjFmLAorICAgICAgICAuYXhpM19sb3dhZGRyID0gMHgxZjFmMWYxZiwKKyAg
ICB9LAorfTsKKwotLSAKMi4zNC4xCgo=

