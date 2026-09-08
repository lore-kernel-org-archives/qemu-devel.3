Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43691C79FAD
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 10:18:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3stO-00043j-Sl; Tue, 08 Sep 2026 06:17:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.jones@oss.qualcomm.com>)
 id 1x3stM-000439-KD
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 06:17:28 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.jones@oss.qualcomm.com>)
 id 1x3stK-0001XF-Mq
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 06:17:28 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 688ADNUh2005629
 for <qemu-devel@nongnu.org>; Tue, 8 Sep 2026 10:17:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=D/eIz2W0L9+SZ/8icAFjl/Li
 ZCQeh/Iq7CLNtM2lN4w=; b=Bh1/o2xgeP5T2fRFcIgQSnaLiBtu6J0yT28sICkO
 agRNCkWxgyziotpxQojNQqPI82YxC4sma3Huv2k91XVGvmGk2XVQ6jy8f6tpjqs2
 xPnkDw1OvL7X0YAuoi4uSALXgvWEb7m3qo1HohTh7auu1nGIYezzjg0TkkntTZwO
 jOHgyFbAZV2kmzHVigJEhE9AwRvY/WTRJEaYBm00otOZ8zLyn1lOLcwKkWiKFGts
 kiX/QwXvUERFH7uK9lEbNOUI4U5qVCMxzv1p/nUJ4kZIZZkGocrFjLiYZzLoewFm
 2cY7FenxGGFvPmIrpfmGUgCwqHnN4G4m/60jyg0Q62A2jA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjatjhfwd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 10:17:24 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93975d63ffcso492348985a.3
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 03:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788862644; x=1789467444; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=D/eIz2W0L9+SZ/8icAFjl/LiZCQeh/Iq7CLNtM2lN4w=;
 b=FRLRnGSiY03q17HpE/k91zj+vR53PqK1X2pSZhZGzrhprPlOcKHF3jqwW2L/jNO9Wr
 +bBqKe6SxTMu+UujCe8NZD65373MjKausycG10DZLouotQrrtr8ontNdaJbS0fKyRIqF
 3Kl0ZYu/ZsoQge9f/Gm9f64qb3/0LlIVw1aXhxqxX6wTfMZI9izs7XF429xd+VYIoyA1
 +COOPk4U40JALGL3bPurgJghvqyMlueoU5Lis149N2YnzicNthy1PrG26v1oBXRLrblI
 Hoxvx9/qRQZmbF82FUlbQX1CZPW2C/16lixz4SiUy/A+wtGzpKYW6GLCN61MiY/YEImC
 GG/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788862644; x=1789467444;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=D/eIz2W0L9+SZ/8icAFjl/LiZCQeh/Iq7CLNtM2lN4w=;
 b=IZuxXmq5L6iKrRi621YcxlZSd/YbdCSTcBFP9BJhK48uCvn+RxXvGAEFh9/0RhPpFu
 iqs8W3UaT3437cWdtusaCODgCpWzzacFVTkSK1/XfMABsT2YNxHiQis3TatFsiJ14TZz
 syvDEcaOuVnzhrSa8oiErWZA9MP5kpfACgYrZs9G7SeYwk2vDIY+TxaH6rFc3Wgxt4Yb
 UYV26u6qyXxqrMaioflf0XuhlMAD+/0lHgnpDT9Ll+wfLC9S7vAq1DZErFSB3/CtexlU
 7RoPu4kaHoGOZKdTyOMmSQObq0Qt5Rm8usU6JyjyDhw/JIkV3m7ddHks6uFQP22+44Gd
 FDxQ==
X-Gm-Message-State: AFuF++n0QGWaeOTkHBnchPXsWPgygW5eASdalfCFnPQGY8qwD9MEWNPK
 FRlXIBrWsbSzeD2uTkLjXBWZaKpa+ELWzU8jDap/2vWqL5B5sDGGvQQu6lD/oTQrp/k2xJ21Q2+
 D2YMurMHYvclvkQzsymfO6lIrtUwqYtjL8yFNyqjend7P2r1WOb3Gr/R/Yw==
X-Gm-Gg: AYBFou2ZYIfF0GTSAdLQxFsYgPhDFLPJmc+PAnyOTIoudAQ029ynndHqFVXiPVE5XKz
 0U0eT5AthfBYSkOMAAZS8kA0Ylsf7C3YVcuq/Rj7lEpqEijE7fJBoNQMYxBWB5c4VlPaovKnAGq
 ME2Zs59DhAXp0XHfAI/1QSma/Jxuhs97MKFuPRBEGZNBFucdz6Rb7Ix3PuTRkWPKyYz/5ZDOyUk
 oPhMM/1W3jh78zBv8OpXgMn2k9aeLxIjiu9bAaxqfA5WQqPwK7tY/jRv863Mfn1ewme87apaBxG
 9v/EjERha02TNR/Ljln+B7Kk+/C0r9XLHleTiGjXyL16I9TZnsTp70Z8HETTdk1Vdr23OmO1Zoy
 mdNIvH8oSkMIJE049ZcK4RejwC8MhKNZ+YpEm6w==
X-Received: by 2002:a05:620a:aa01:b0:939:35e5:94ba with SMTP id
 af79cd13be357-9398031e112mr2770251285a.6.1788862644018; 
 Tue, 08 Sep 2026 03:17:24 -0700 (PDT)
X-Received: by 2002:a05:620a:aa01:b0:939:35e5:94ba with SMTP id
 af79cd13be357-9398031e112mr2770248585a.6.1788862643681; 
 Tue, 08 Sep 2026 03:17:23 -0700 (PDT)
Received: from localhost (ip-86-49-245-11.bb.vodafone.cz. [86.49.245.11])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c260d575fccsm607057566b.37.2026.09.08.03.17.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 03:17:22 -0700 (PDT)
Date: Tue, 8 Sep 2026 12:17:21 +0200
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, leif.lindholm@oss.qualcomm.com,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Nutty Liu <nutty.liu@hotmail.com>, Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v10 4/5] tests/functional/riscv64: add riscv-server-ref
 tests
Message-ID: <72i3sw43dwea2qqxtya7qx4h3azfxadrde76kl6e2gqnua53pp@eqtn5466liio>
References: <20260904195610.964829-1-daniel.barboza@oss.qualcomm.com>
 <20260904195610.964829-5-daniel.barboza@oss.qualcomm.com>
 <5pcda5mlbnlftgqemlix5sudyutlje7l66rmy7wjsvzmkrbju5@zsofeqrhmnos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5pcda5mlbnlftgqemlix5sudyutlje7l66rmy7wjsvzmkrbju5@zsofeqrhmnos>
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDEwOCBTYWx0ZWRfX3BysGCA0Jk8L
 vfYH265fVLMNN20TF0zb13nkw0ddSvYGmzJRHd/qZkFfykjtE65bt03HSesi38Xg29l75sOatUH
 ID6baPOpD2i4XCFZiHSoRPtrbQGUZZ0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDEwOCBTYWx0ZWRfX/K4mNEBNv9py
 2Qj9l5yMfakT+cNGQZRb2z335bnVDgTsfhNl1a9wReUA3LsYRgxn30N/wBXmFJ3JjpjIjlQPQ2J
 2lICzapnCKkp7wulGCWPBqaWJm4mGv9C/cCyYXKCMt1bWQfwESVx1CBDjdKlqcPg5w+v2ej1rh4
 1GyyxMuKGQEMFjcL1v03xTPqrJcQ1PiMEfSE/fuAhEnhLmD5GN6Rq11C+yizkiEP4MC1IMaOhcQ
 WXGXEZCnzBcQQORescDhaH9qZBDROHk7EPlr0S7p98fHSYPRVfGP33636RvqGEBz04nlCV7pdM3
 R/x6LLoYG/Lo2bRlj1HowIV3E0HzYLzmCLHPLG3Ft3qFxs1K7J+fJaVTD50H1iKMKP1ceYfjOED
 cJjkwcKPkyRF7z9+eHaaPMgzKiB/BsuT98WKaYQ1MJmtYsxqPKOEuhcMXGjuyDCSaNNgAtZ68B2
 bpzNihhKp4dI6EJrDSQ==
X-Proofpoint-ORIG-GUID: DAhXKYV2LphlYuQBtXXf5e5_HWEZp0sc
X-Authority-Analysis: v=2.4 cv=QrduG1yd c=1 sm=1 tr=0 ts=6a9fe0b4 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4CXLxsOAgPM/krjtHEZQyA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=4SlSymV0zzcDb60NZQUA:9 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: DAhXKYV2LphlYuQBtXXf5e5_HWEZp0sc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_02,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080108
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

On Tue, Sep 08, 2026 at 11:11:49AM +0200, Andrew Jones wrote:
> On Fri, Sep 04, 2026 at 04:56:09PM -0300, Daniel Henrique Barboza wrote:
> > Add tests for the recently added riscv-server-ref machine:
> 
> This commit uses 'riscv-server-ref' instead of 'rvserver-ref' for the
> name.

Ignore this. The machine name is 'riscv-server-ref'. I was thinking of the
cpu name.

Thanks,
drew

