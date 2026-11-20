Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33AD606A320
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 03:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=S8hq7YJu;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OZ/JSNl9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUFhY-0007vp-OE; Thu, 19 Nov 2026 22:54:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xUFhX-0007vU-Js
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 22:54:15 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xUFhV-0000n2-V2
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 22:54:15 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AK3VF8E2143534
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 03:54:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 eWks791oiNzFmxc/I0ku3N+lNghigWZG1hXFiqdU3OY=; b=S8hq7YJuB14kvMaq
 RP+ReYmvoi02pWquV4RVLL0IJrOcyI8szqeQ9ZsQGLTDohRyw0ZhIRS6ALEDCV+6
 im21hCqJOexitcXDbyPZGIgUvEF77Bf7XukHwsLbHCKl2DhtdPqNUqnRsMc1tP2r
 22HfIFG/FuB6xFSmTOBijbIq1gvyTW1TS/wHzpJHBF8JvtFZ4T475HvNknUl27O/
 199dFuGJ2dX17kjOIzfyZlMZPVPL5oCTLHIAXnYQ/aIglEraznVs0kHLRvU8Ud+o
 76h4diEk7R1WVWCDT0+h2ZazUBsoeD2qaEYq/WGiisNvopbp420Ied0hYk8b41nZ
 HSzF1Q==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j27au1pyd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 03:54:12 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-38531c1a566so1001739eec.1
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 19:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795146852; x=1795751652; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=eWks791oiNzFmxc/I0ku3N+lNghigWZG1hXFiqdU3OY=;
 b=OZ/JSNl9+faNeHkRwD73Qq8m5u5wt42vJ5/4UYJt/2+lpHtFkNLXpyjH08P4n4zPEE
 IeEiImvhtzjzapNDaDhK3OFb3+SOeRVlVD+paJ1qo9Y9lpeH4ag2aL/PmO0rOe9UZMX9
 m3sBOK/RdpUPiP4tbMOemwJgHrblFztP0p3SlhAalJuI9iDdNSyn5YcLu+KykaHVTlTV
 4Hhgl0ZJptUeBezIqqZScBGgoCdNUiHDztjuLlRzlR4fJ63soT0TAH49aBP2W9qHjc52
 MhiKIxE2KWbvZPiGRaJrQbwD4u1m4XcQMvBk6bnoaiSJNjuu6Rjt0boOPY6nteff+mrl
 hArw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795146852; x=1795751652;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eWks791oiNzFmxc/I0ku3N+lNghigWZG1hXFiqdU3OY=;
 b=d73Pwcv0ZAw+s2mU4OI80bKBmC1jRp3eV7dbAaJ+Wdd/+MxGAuV2bmcEK3f8qff7dD
 8wrHNqtcZpFZyDMXfgtCQdiK+Mjf6Pe6p1tU+Wm84GzGqpglnA1o4yulg8dxvHTOFF74
 RhdMQyNQm4soFDxgwM+7ihU226BINtmqBbvQKA97uITcHTxtwIClR/Ru+PqCW2b0oQmA
 7LZKHbC5Cv5lbq86ALVrKHpppolMIToF5ke9AG6wxpnbpyOAgGCU3vcmYsHd1RWnDPAi
 kKAvLdsTMcJU6gyqZQJO6Acm3WfOXsXFAjtYh6OlZLzb2oGxX8Yw6QBe1RuqsVGkOl2D
 rULA==
X-Gm-Message-State: APuU4Z82BZ2EvpF2LgsOHHDmg9G0jVhr6/N8fnBiqhAzg8YUkOXKhXcU
 HGBGwx8WyFgOsfl5U0MRFJQTcClS/zp9aos2lKNCzUKTosI2nXLqDCgh6FM14Wh7WsA/cLogL4Y
 fKpxiOuV0c7vSqqS409+nEcijFUM8QfczgrenqjgZ93LT3IKK+EwA5CkP6h+pT/cx+Q==
X-Gm-Gg: AZFdTZfY7fjOKqvSVUe89TqRJ83UC3F1UQxg2fo5Yf6VEf9qzxl5eX+WHwhbAmZWZag
 8MwsqxHqWyjWSJCJ8zC+K69ClU7DiN7l8bgZUKzWZL+wHBLVSJ4NNEyqvka4hKgco0kqeSXAG8K
 xhzd6hpPIBnsRnAIGkEzXZ7YY1TQ/D85IsV7YFih0FcYNh7j/W1a1RAmWPOeDOwTmlPfSiw7Txi
 zjRnAMSK5GUVF98x6vsoQGNTl2o8lk5bBeUe6iOAcs569uwCzIeXs1G5PcP8k0y8pwbs2DFeHPj
 CApXPTIFTZBCFXwU2cyPV+bIxgwC3zj7T+IWevEgxUfBac88EDut0RvmO5v8dzz/XSKEf9+yKbh
 cft/nk1wXmVCF2yf6Uov2g+Vxfkwmd/GDKhmnLchYf8yUvmLltMPkxH0+jEMk3vs/nZk8z0B67v
 1OqzN7eCa+bkpiEZ8C+9rF
X-Received: by 2002:a05:7301:b02:b0:382:48a5:cd53 with SMTP id
 5a478bee46e88-3857111f187mr1620018eec.31.1795146851875; 
 Thu, 19 Nov 2026 19:54:11 -0800 (PST)
X-Received: by 2002:a05:7301:b02:b0:382:48a5:cd53 with SMTP id
 5a478bee46e88-3857111f187mr1620002eec.31.1795146851479; 
 Thu, 19 Nov 2026 19:54:11 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385665f21aesm3854126eec.4.2026.11.19.19.54.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 19:54:09 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, qemu-stable@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 8/8] linux-user: copy nanosleep's remaining time on EINTR
Date: Thu, 19 Nov 2026 19:53:53 -0800
Message-Id: <20261120035353.3215703-9-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261120035353.3215703-1-brian.cain@oss.qualcomm.com>
References: <20261120035353.3215703-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDAxNSBTYWx0ZWRfX+wMVNfoTnHq2
 Mt7+YyGnLQ42pW6qliqXoSXQ3+Q4QnMDl00WU4AjQei+oifXO6JFd2VQSgdthG8q5KkXIbgnkNt
 JZoqd0XD5dNUgSSY2qBbeUIijPVXaLBP4ufB5zlXvvWo77YZmEYXmSW4JRjyck+UlAU1nGBTPgA
 gUmnZBsSGgx4I/+U6NonI6JtttNqSvf4QE+ag6uPMO8TkPCR0GPT8PDJ9hid2+3IHCUHpkLS3qG
 YRYvZPyKVzza/eKjiffgY8wJd+0EA6mDSz5/a0NAcm79rG0ST9y7SViL0QnOhLUaitdB1vFpr+Y
 CYBLOS8S+T/O7kdTBYKZMJOdCd/pUnT2/Xgnr+8jMqB6GY3AFYX32nN/qm551YX1/vPrTUQcZnz
 Tis0eYzHCA6MG8OrqXzAVsaFcWaCuQ/3bULX5St2wUi/932tPliLc0nx0QY4c2IHHhlQTJJLYTr
 s9BiOwiCzAGTU46CYCA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDAxNSBTYWx0ZWRfX0SMjEnWWlv/g
 k/7vm8ReCXCsd51qCZCyOsgLo08Tpa2iosCTx4kspGtvfQ04S/+voy1NlEgi2crPmeeCQ0hycdO
 dlaG0T/Qyu2nl3hF3p+O9vgq3Og1sO0=
X-Proofpoint-ORIG-GUID: VTu7mydMGDM6M9tw1en1m06DPycaoJXi
X-Proofpoint-GUID: VTu7mydMGDM6M9tw1en1m06DPycaoJXi
X-Authority-Analysis: v=2.4 cv=KuHYSmWN c=1 sm=1 tr=0 ts=6affc464 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=48bKN7e9TvwGekxNErQA:9
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22 a=Fg1AiH1G6rFz08G2ETeA:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_02,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200015
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

ZG9fc3lzY2FsbDEoKSBjb3BpZXMgdGhlIGhvc3QncyAicmVtIiB0aW1lc3BlYyBiYWNrIHRvIHRo
ZSBndWVzdAp3aGVuZXZlciBzYWZlX25hbm9zbGVlcCgpIGZhaWxzLiAgQnV0IHRoZSBrZXJuZWwg
b25seSBmaWxscyBpbiByZW0gd2hlbgp0aGUgc2xlZXAgd2FzIGludGVycnVwdGVkICgtRUlOVFIp
LiAgV2hlbiBhIHNpZ25hbCBhcnJpdmVzIGp1c3QgYmVmb3JlCnRoZSBob3N0IGNhbGwsIHNhZmVf
c3lzY2FsbCByZXR1cm5zIC1RRU1VX0VSRVNUQVJUU1lTIHdpdGhvdXQgcnVubmluZwp0aGUgc3lz
Y2FsbCBhdCBhbGwsIHNvIHJlbSBpcyB1bmluaXRpYWxpemVkIHN0YWNrLgoKVGhhdCBpcyBoYXJt
bGVzcyBmb3IgYSBndWVzdCB0aGF0IHBhc3NlcyBkaXN0aW5jdCByZXF1ZXN0IGFuZCByZW1haW5k
ZXIKYnVmZmVycywgYnV0IG11c2wncyB1c2xlZXAoKSBjYWxscyBuYW5vc2xlZXAoJnRzLCAmdHMp
LiAgVGhlIGdhcmJhZ2UKdGhlbiBvdmVyd3JpdGVzIHRoZSBndWVzdCdzIHJlcXVlc3QgYmVmb3Jl
IHRoZSBzeXNjYWxsIGlzIHJlc3RhcnRlZCwgc28KdGhlIHJlc3RhcnRlZCBzbGVlcCBjYW4gbGFz
dCBhcmJpdHJhcmlseSBsb25nLgoKTWF0Y2ggY2xvY2tfbmFub3NsZWVwKCksIHdoaWNoIGFscmVh
ZHkgb25seSBjb3BpZXMgdGhlIHJlbWFpbmRlciBiYWNrCm9uIC1UQVJHRVRfRUlOVFIuCgpDYzog
cWVtdS1zdGFibGVAbm9uZ251Lm9yZwpGaXhlczogOWU1MTgyMjZmNDMxICgibGludXgtdXNlcjog
VXNlIHNhZmVfc3lzY2FsbCB3cmFwcGVyIGZvciBzbGVlcCBzeXNjYWxscyIpClJldmlld2VkLWJ5
OiBSaWNoYXJkIEhlbmRlcnNvbiA8cmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZz4KU2lnbmVk
LW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIGxp
bnV4LXVzZXIvc3lzY2FsbC5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvbGludXgtdXNlci9zeXNjYWxsLmMgYi9saW51
eC11c2VyL3N5c2NhbGwuYwppbmRleCAyZmM2MWIzZWFiYy4uMzUwZTY5ZTJkMDAgMTAwNjQ0Ci0t
LSBhL2xpbnV4LXVzZXIvc3lzY2FsbC5jCisrKyBiL2xpbnV4LXVzZXIvc3lzY2FsbC5jCkBAIC0x
MjI0OSw3ICsxMjI0OSw3IEBAIHN0YXRpYyBhYmlfbG9uZyBkb19zeXNjYWxsMShDUFVBcmNoU3Rh
dGUgKmNwdV9lbnYsIGludCBudW0sIGFiaV9sb25nIGFyZzEsCiAgICAgICAgICAgICAgICAgcmV0
dXJuIC1UQVJHRVRfRUZBVUxUOwogICAgICAgICAgICAgfQogICAgICAgICAgICAgcmV0ID0gZ2V0
X2Vycm5vKHNhZmVfbmFub3NsZWVwKCZyZXEsICZyZW0pKTsKLSAgICAgICAgICAgIGlmIChpc19l
cnJvcihyZXQpICYmIGFyZzIpIHsKKyAgICAgICAgICAgIGlmIChyZXQgPT0gLVRBUkdFVF9FSU5U
UiAmJiBhcmcyKSB7CiAgICAgICAgICAgICAgICAgaWYgKGhvc3RfdG9fdGFyZ2V0X3RpbWVzcGVj
KGFyZzIsICZyZW0pKSB7CiAgICAgICAgICAgICAgICAgICAgIHJldHVybiAtVEFSR0VUX0VGQVVM
VDsKICAgICAgICAgICAgICAgICB9Ci0tIAoyLjM0LjEKCg==

