Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20EB2606A319
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 01:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Ykkqemmx;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jxV8BYIr
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK4T6-00072r-7W; Thu, 22 Oct 2026 21:53:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xK4Ru-0002xb-DF
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 21:52:02 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xK4Rs-0006RU-EX
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 21:52:01 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69N1FKpP2391394
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 01:51:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jexRnTQME0hmMCK54q5511ukVzz6PGBZKp7f4mUho5c=; b=YkkqemmxH3pOdh8Y
 8jZKLjgedPO1B6S/YT6XkSDt7x9t9cBbOuPtXfV1tacDIDijyBU57ZSU9nOR11pJ
 03AzILX/X7z93DNelvpFMpfqPaWkHa7d4KQ1bQONZKJufo08BO7+Vjd8GWv0o3Ri
 RnNhTp0QgPMR3pOCdox3uBSAyEGcjMNTrQ/b9o64ll0lsgOaI2zr5aU9YaD5DdR0
 BbMNJ67+Lg+T7PJ8z4tov4oFulK2YEcdbrQ0qYb+CMJzkg5BYDiT0RpcnkEQmb8w
 RcmYTgBuoaYWxR+zhnYbQhh5tN/U/V6ohbZfijOG9/EaJIxw9J05ryRB9UKmoOnv
 mA9Wpw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmp9ca3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 01:51:48 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30c0d568830so1040784eec.1
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 18:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792720307; x=1793325107; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jexRnTQME0hmMCK54q5511ukVzz6PGBZKp7f4mUho5c=;
 b=jxV8BYIrHueOGzSgif4+MIrFIw0Cg+AWQbatBuQttF6kLL+219ADH/MRnqt7xw0uTS
 rnu4KUJKifp4EmXq0EcqS3lw4ovZ4h5qMvzcRVHmOrfLhz9eeYlLTagUnUsP4h/7oNik
 vJp+vF0O3Gb2OYYsCnhO2hm1eXJRXcu1wrisP8kXSld1QNIiU+havAfC50L3eKJ97A5U
 yaJapxkN9mrd1K7k9JETGiP2OK/quiauji22BajRgihh8pAf1nj2NF6vd10ttjFIoEYl
 6gDS64Y8mM/v+aIoi96X+cWFZUwZ60btxWpXMJ2oEgx3pdQZ6zrplMgyIGcFIIgxWLi4
 M45w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792720307; x=1793325107;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jexRnTQME0hmMCK54q5511ukVzz6PGBZKp7f4mUho5c=;
 b=DC65M0ofbzn+MMU10UfoPf2gVR4e+rstcVHgM3zA4IUOAT/702YVkGSVbeOIKMSB0L
 HBlD7T1EMT75rMkMO+NzMGYam0P3RlMi+B+EewNhMhJsz4bNEoil9kNJt44nUn9xW/bt
 Xa5nP3lB1k/GLApKi1VPhUeZAmdvKcDViP5vdmCsmXcugjy/21/jP6VMYByzJhes5TV2
 fsWS1ib0sgrw1Iy3jQY4zDy+t7I5Aqs2jXvlFwLd25xCVSVOQplmTY7SgEkp6hU3ERrA
 x5BgCunW0d/dDoZvCGZl7Gw8nCRMTcFOYJSH2WZn9SOMDlYhPIGqwF1TOxppWuBOsy0i
 oUtg==
X-Gm-Message-State: AFq9FYKTmiSfdbTjTw5Jqq0vTaVWfYm8CmUGjukylrVWCL4kzRTptfS3
 PTbq9MBHFKMLGM+XlW7G2bvL/u/pjvIPVIy2LNhMK6fGkFsupEzo01z8+106D2ypyn3CNW09nGv
 xMU1HsPiq0ueqLss27RAJaEKDes6dDn9ad1AKA6wy2N80njGyq1RHwTn49ityqj8+KQ==
X-Gm-Gg: AYBFou2xRjCFilFsg4uvV3Pf7AFaa+hIaYGf1YgYrkAvXeGl5VaivitBUb4xPd2ESd3
 wlxCF/q3dl6XpkgfNf5cdRbXe52pDAM7sw8qV1ALkmw+aeCC1AXSRTsOw+p6kYFuzPeTI16CsiD
 5ZxdwtljuGZLnsUrALCTTttv55W95/z9mO/C54Q9XP+wt7qqqkXfKWyKHTqjEnEWqpgJL5fVId/
 dmtAFBcDssmDs5YO4d+H/kO7q3afjTKxIMEJrAno7vkwNDU90YLCp7nWPKZ0nf+UbZ8h/xcl21z
 P+4WRG0iLSuwhBgiqM4q38e38u8K/MQf2aMXS0oMn11ytGjT4JM0XPlj2JhOqBUgR9LK2y2BYmw
 kzU0Wqyp7ssdEjS4NKgv3NeFm8FebaSrcdIRh+mhSrROD5tSp
X-Received: by 2002:a05:693c:8345:b0:35c:99e1:c755 with SMTP id
 5a478bee46e88-369d97e2a51mr917561eec.38.1792720307073; 
 Thu, 22 Oct 2026 18:51:47 -0700 (PDT)
X-Received: by 2002:a05:693c:8345:b0:35c:99e1:c755 with SMTP id
 5a478bee46e88-369d97e2a51mr917537eec.38.1792720306431; 
 Thu, 22 Oct 2026 18:51:46 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369d9d5fadbsm1948565eec.8.2026.10.22.18.51.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 18:51:45 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 39/43] hw/intc/hex-l2vic: find the next pending irq a word at a
 time
Date: Thu, 22 Oct 2026 18:50:36 -0700
Message-Id: <20261023015040.2473105-40-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261023015040.2473105-1-brian.cain@oss.qualcomm.com>
References: <20261023015040.2473105-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAwNyBTYWx0ZWRfX4LW0Kuxo5go9
 8+nUA+ib2+15DpzrdmQWZ80ZfXg8Vz5sppMg2XMUxBcr0Y7QJO7CWsyn/pnnZrGa7BWtG+WHtzF
 c+0ui1dhxkY9sR82GtP/8wPL5zG5tSI=
X-Proofpoint-GUID: 4_1qdAW9iKWfwZtLcDr35mGnd8GvYnf9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAwNyBTYWx0ZWRfXyHfvhdGKHbrd
 GGxcZqNFK85gxdZea1PbjL5EH/gqXZvVeqH1SMc1ZkXxGpmNVc6XApOSWItVpbrIIythMhVBWyz
 +8yr31fFNHtoJp3IhEzTrchGp3hsEO0s325/FycvBi8R7Qo1Qfi5Zl0Y+8hViBhQEwqZRodHOIU
 M0iPBFntSPECW0sMYaMX1AeVKTv2ytqJuGe51FdCaaCmbN1PZvJ9ddy6pVPc44Au3hRgDQqT5UQ
 JZ6DzLi4NExx9uQEXcJg/kewNlZcWXR70u1mJYwECdUifKrJbSZfiN/eVbRxFssoe2sifSpEFQi
 FgSR6a20EDEhreAcAzxrQv2j3uAiji4BCHAs7/n9e+5C9HsX5lBxrzJCpzOXXJKxRgf1XrspLMd
 u0/HBPQ7fP6fYKEvmyI2iOGPd3ntxu1zF252J/WzoXiGT+W4gu2EzArCi1XlLnzBQ/M7lvoduP+
 FyJPsC9DV6s4kGHLBkw==
X-Proofpoint-ORIG-GUID: 4_1qdAW9iKWfwZtLcDr35mGnd8GvYnf9
X-Authority-Analysis: v=2.4 cv=BdBNQbt2 c=1 sm=1 tr=0 ts=6adabdb4 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=8fQjqy5ARp1ca2tc:21 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=XWoxCBOuUWUKfCXQB-IA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230007
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

bDJ2aWNfdXBkYXRlX2FsbCgpIGNhbGxlZCBsMnZpY191cGRhdGUoKSBmb3IgZWFjaCBvZiB0aGUg
MTAyNCBpcnFzLCBhbmQKZXZlcnkgY2FsbCByZXNjYW5uZWQgYWxsIG9mIGludF9zdGF0dXMgZm9y
IGFuIGFjdGl2ZSB2aWQuICBjaWFkIHJ1bnMgaXQKb24gZWFjaCBpbnRlcnJ1cHQgcmV0dXJuLCBz
byB0aGlzIHdhcyBhIGhvdCBmdW5jdGlvbiBmb3IgYW4gT1MgYm9vdC4KCkNoZWNrIG9uY2Ugd2hl
dGhlciBhIHZpZCBpcyBhY3RpdmUsIHRoZW4gZGVsaXZlciB0aGUgbG93ZXN0IGlycSB0aGF0IGlz
CmJvdGggcGVuZGluZyBhbmQgZW5hYmxlZCBieSBzY2FubmluZyBpbnRfcGVuZGluZyAmIGludF9l
bmFibGUgYSB3b3JkIGF0CmEgdGltZS4gIFRoZSBkZWxpdmVyZWQgaXJxIGlzIHVuY2hhbmdlZC4K
ClJldmlld2VkLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQG9zcy5xdWFs
Y29tbS5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxj
b21tLmNvbT4KLS0tCiBody9pbnRjL2hleC1sMnZpYy5jIHwgMTcgKysrKysrKysrKysrKystLS0K
IDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL2h3L2ludGMvaGV4LWwydmljLmMgYi9ody9pbnRjL2hleC1sMnZpYy5jCmluZGV4IGI3
M2VjYjgyMWU0Li4yMzM1MjM2ZjgzNyAxMDA2NDQKLS0tIGEvaHcvaW50Yy9oZXgtbDJ2aWMuYwor
KysgYi9ody9pbnRjL2hleC1sMnZpYy5jCkBAIC0yOTAsOSArMjkwLDIwIEBAIHN0YXRpYyBib29s
IGwydmljX3VwZGF0ZShIZXhMMlZJQ1N0YXRlICpzLCBpbnQgaXJxKQogCiBzdGF0aWMgdm9pZCBs
MnZpY191cGRhdGVfYWxsKEhleEwyVklDU3RhdGUgKnMpCiB7Ci0gICAgZm9yIChpbnQgaSA9IDA7
IGkgPCBMMlZJQ19JTlRFUlJVUFRfTUFYOyBpKyspIHsKLSAgICAgICAgaWYgKGwydmljX3VwZGF0
ZShzLCBpKSkgewotICAgICAgICAgICAgLyogb25jZSB2aWQgaXMgYWN0aXZlLCBuby1vbmUgZWxz
ZSBjYW4gc2V0IGl0IHVudGlsIGNpYWQgKi8KKyAgICAvKiBvbmNlIHZpZCBpcyBhY3RpdmUsIG5v
LW9uZSBlbHNlIGNhbiBzZXQgaXQgdW50aWwgY2lhZCAqLworICAgIGlmICh2aWRfYWN0aXZlKHMp
KSB7CisgICAgICAgIHJldHVybjsKKyAgICB9CisKKyAgICAvKgorICAgICAqIFF1aWNrbHkgZmlu
ZCBsb3dlc3QtbnVtYmVyZWQgaXJxIHJlYWR5IGJ5IHNjYW5uaW5nIHRoZWlyIHN0YXR1c2VzCisg
ICAgICogcmFuZ2UgYnkgcmFuZ2UgaW5zdGVhZCBvZiBvbmUgYnkgb25lLgorICAgICAqLworICAg
IGZvciAoaW50IHNsaWNlID0gMDsgc2xpY2UgPCBTTElDRV9NQVg7IHNsaWNlKyspIHsKKyAgICAg
ICAgdWludDMyX3QgcmVhZHkgPSBzLT5pbnRfcGVuZGluZ1tzbGljZV0gJiBzLT5pbnRfZW5hYmxl
W3NsaWNlXTsKKworICAgICAgICBpZiAocmVhZHkpIHsKKyAgICAgICAgICAgIGwydmljX3VwZGF0
ZShzLCBzbGljZSAqIDMyICsgY3R6MzIocmVhZHkpKTsKICAgICAgICAgICAgIHJldHVybjsKICAg
ICAgICAgfQogICAgIH0KLS0gCjIuMzQuMQoK

