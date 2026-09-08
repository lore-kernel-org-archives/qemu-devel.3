Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ADD7C79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 09:12:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3rs1-00072c-0X; Tue, 08 Sep 2026 05:12:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.jones@oss.qualcomm.com>)
 id 1x3rry-00072K-1N
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 05:11:58 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.jones@oss.qualcomm.com>)
 id 1x3rru-0003FL-RC
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 05:11:57 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6886LcPA3299120
 for <qemu-devel@nongnu.org>; Tue, 8 Sep 2026 09:11:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=QC6qhvdU3pT7y10dLqA7CiXf
 l7RYcOBKBN5mbZS7txk=; b=UoqmlDPXBGKXxrOhhb4gOj3F3UbNFINMVKD9kNCU
 TlnBXBqhWrDrs6XNfH4o7HcjZzHFaZHVOLqffuNXY7yDYVfG6aqhlCbvaj3EF69r
 axjFWd8YkXcPWtFkvpm+rqREzZ7Wq+OFKXKpF1WXPgYXOAi5V7qNWZgxGFh7omVE
 mQfWtldu1We3TbnqvU9N/ZPLdImFuUBuiquStBRypYcUvfVjq6nDAT3ciGgJd/nB
 3QU7jcniuJ89csm46O3TUpakY5LE9Sa+JOBAEVJBAwnvS+VruZ1ZF+gJ5YVuZqGK
 53WdQKDgUUpEOV+BphVcuFTp4/8jVMKANagHJNkXUUX8iw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjb0p94rq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 09:11:52 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93915f50a5cso1054793385a.1
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 02:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788858712; x=1789463512; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QC6qhvdU3pT7y10dLqA7CiXfl7RYcOBKBN5mbZS7txk=;
 b=MRRMlhZ6MslQ+UkX3PuuSEu1alJDA7vSFx+wOBoHYwBgq/ZRqnS5nVdqPyB6Uk0+NH
 7d5ArZh8mQyQqDjE1Z6rMG7oDl1y7RbFJdEbcrRfjBUooNuoI3jB31eWe3XlqQUOj7hU
 PnIMy7VSDrNqGMEzYfC6zK0xrETBjSPG+SpqsSXwAmhB/SyhKRixU0GyGK4SHBXAAwx8
 uBocrYMap5lLh6VFoMecN4b7d/ZFdliuMRiKY0oCrFUnB8dbIc9IyHMRxqirAsnT+Pi2
 n+U4MZLm1Y3wdkTDFfxUQPFnL100dIjKF9XdZPZamyR/0vBsiVFMNEqSmFe2DZEBjPBx
 ALaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788858712; x=1789463512;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QC6qhvdU3pT7y10dLqA7CiXfl7RYcOBKBN5mbZS7txk=;
 b=R0EV7RX3kR2cuLEhK4xgfIQdP6NktvDtHe+ywKDA+f79kWLFgLk6WsYvjS7QUVgjmF
 UOxOIryFwao44/cuw5LEAWy0AGQED967dSBX1HzGhctBse+TlIMTFwN8oW/M15AbMK+0
 n5OeEIo5KU6FPzVRTV+4XtcpxEPIIxjvpDCE8q/6BKzYmKJe2LXPZRyBDRHaRA/DQ2PK
 p466c0O65j+/aVrWCgXCR+TVPrjdUzi4dz1q05FJE3IezEwF6joR4SaCnmncIJGDHgs8
 K0I/w8YRiZ0XhiE4FRO+13zcqEoIS21ZE5+TJ16cnNk8lN4S+ExUapBeCjRDMMa0k/ow
 4Nug==
X-Gm-Message-State: AFuF++lm1khXe9p0a2jMeOpKqJoky+L1nb1mre8d9Gjl5CWW3MiykIfy
 tdJCwJ19Qus4zi39nycBcdLYPK7JAG09DFiRPspT4C5pj4FFM3IbcVZBAb6Il9aHaAg0B7oqG2Z
 y+SWGJrcP2SWt3KQyFlpTSzNho6rNVqNiBLppOIS98+sm+YEM30TSLAsGhg==
X-Gm-Gg: AYBFou2fcbUOfU652OgguxeUimGbKYTqyyfiF36Z0nv0FuX3T/b+QOKIta1yNESVuwX
 tlUv2ihn86chLKn0JjsQPqaOTGFngWKVohOIJe5WL+hdrLDBXglqOoEdeUNTNvQZguX9FgFMB+/
 KaJ3LvWlM2x0E1de241OCZ+ZGRr86Q7Hu/TratdhR/HnyTJ/seTTmlRDfASiCLei51ADIVQYatM
 tsWqtBdWYF/aE09pBn6je72s2o4+36FSCvx+GFiKnJKeFB9gh5OIZqonQYx5ptg2DJFFeMXLS0+
 4iLJh5U/z2L4CWJpyw9ApqKDna/x5X/YyO88CxTXFK5zdNwYbywF/cFrC+s57Ge9OqUSKHgi4k7
 09IIdrHa2OyRbg8NgXZV2yceERBk91LDvlB7a2w==
X-Received: by 2002:a05:620a:bd5:b0:937:4550:96c9 with SMTP id
 af79cd13be357-9396e0e1302mr3016416785a.21.1788858711926; 
 Tue, 08 Sep 2026 02:11:51 -0700 (PDT)
X-Received: by 2002:a05:620a:bd5:b0:937:4550:96c9 with SMTP id
 af79cd13be357-9396e0e1302mr3016414585a.21.1788858711533; 
 Tue, 08 Sep 2026 02:11:51 -0700 (PDT)
Received: from localhost (ip-86-49-245-11.bb.vodafone.cz. [86.49.245.11])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c260d5cfaa2sm580226866b.59.2026.09.08.02.11.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 02:11:50 -0700 (PDT)
Date: Tue, 8 Sep 2026 11:11:49 +0200
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, leif.lindholm@oss.qualcomm.com,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Nutty Liu <nutty.liu@hotmail.com>, Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v10 4/5] tests/functional/riscv64: add riscv-server-ref
 tests
Message-ID: <5pcda5mlbnlftgqemlix5sudyutlje7l66rmy7wjsvzmkrbju5@zsofeqrhmnos>
References: <20260904195610.964829-1-daniel.barboza@oss.qualcomm.com>
 <20260904195610.964829-5-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904195610.964829-5-daniel.barboza@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: IvRDesKj6vcdBRwEIqg13e8xSQBSM5XQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDA5NiBTYWx0ZWRfX5yNfxy2S6wOq
 gY214yOSwRQdQkD/bUr5IJJYL2lKEMllhlDCqE7/ef97G8wlqHR6elNl4zNInKNMn4dvKSj5qPM
 KemMkh5XT7kjm9kG1vQC5Q1hmie660E=
X-Authority-Analysis: v=2.4 cv=HL3z0Itv c=1 sm=1 tr=0 ts=6a9fd158 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4CXLxsOAgPM/krjtHEZQyA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=WguLxQ3cqw7mU-68o14A:9 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: IvRDesKj6vcdBRwEIqg13e8xSQBSM5XQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDA5NiBTYWx0ZWRfX5qZ37Z7HaC9v
 /1MCN2AwGboEDC1Y6usRU2A1vtJd0JbJIuVdUae/mJ16t90DBiTtSXWLZMISVv5gw4su92TUaAb
 Q3+7tAxdQ6dyxqElCzHbhdCmUOIdrqv9Q8p1GNWyiEcIP1TknnssIBZabahIzUdwoQqD+NvzIc0
 y+tUJ0QyuUOFCxMu4knbx3OB2qo+Ys5mQPXkmd0G8Ehj06Qufl+2Z89jUXLt32vIq5YD9gt2S3c
 g+dnZe7Af22+9+okH+noNI7o7MSwhBXtgA+1z3LKx7vmLQKAeTnsgYTDM4Clcytve2Fm6OxRtF6
 06Manjl04HBHMASIZ2x1EQHo2LuURa9ZlmgIVkibIpnbjfvI9XkBym9o2D3sXreLF9EC0m7MdcU
 3CFjGZlB0hDGyYBZNmov48jKJFoqdodARkhaImVHAc+eovnlMk94btPigq6e/wbSaxqZlk+zG+w
 Gg9S+3aPtvJLtEuhwtQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_01,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609080096
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=andrew.jones@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On Fri, Sep 04, 2026 at 04:56:09PM -0300, Daniel Henrique Barboza wrote:
> Add tests for the recently added riscv-server-ref machine:

This commit uses 'riscv-server-ref' instead of 'rvserver-ref' for the
name.

Thanks,
drew

