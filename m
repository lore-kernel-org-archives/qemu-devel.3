Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BB35CD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 05:19:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOqNL-0005IS-2b; Mon, 18 May 2026 01:18:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michaeljclark@mac.com>)
 id 1wOqNJ-0005I4-Ds
 for qemu-devel@nongnu.org; Mon, 18 May 2026 01:18:45 -0400
Received: from ci-2006j-snip4-1.eps.apple.com ([57.103.90.222]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michaeljclark@mac.com>)
 id 1wOqNH-00009e-Vj
 for qemu-devel@nongnu.org; Mon, 18 May 2026 01:18:45 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-11 (Postfix) with ESMTPS id
 AA8141800133
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 05:18:41 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQhKAkMOUhxBCE4dXwJLVxQEFVoOXwpXHFMbXwxFAHIdWBsdDlgGEhZdRV4EVANTFVUSUAFWGVkwVBlQQ1QEX1BLGw5cFwNXHFZFXBhDCV0FVxwdDl5FWxNVF0YJGQhdHRkIRx8KMANCDlYDQwdFAC0ZHFdQWgpRXloXXk1aAlZNBUxQDFVTBEVfVVVUVgofRFgcV0APCAMTFEgLDA5bBkgJTAIJBytfEVpWUAJaVRIEQAhWUF4IXh9MHA==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mac.com; s=1a1hai;
 t=1779081522; x=1781673522; bh=U3IgSxeujyvKOMi89oZlF3JrMfmRjjAwHKKwC1bg9TI=;
 h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type:x-icloud-hme;
 b=mqHA51Z4nemnctq7l1KHkFg/Z22aU5GOnHv0dhlB5a5c+v1tAZ+3On/V4TIskA1Ct2TJIN1d6ZZ+feWJMsxdyRZQq3fa4GGVWBrvsJxjsYvy+JI/mYNmy7XMIkvI0aLia6Jpy0GgeMArfupVSHFEU6cGbtLrP+Mh5t6WbuZMereYQIa4mBi9qn9o4wCJECeVkRcfPMVAy6zrUQIzyVzXFGYDudsy6INn3Ffr5k7U+nJh99tWsTpzzkktOYmCn7/xnb4zP7MlO+psI/aSeWQ+y9z9P24dDsxoSitxOO6Zy8ZZYgWmjFuS0829xW9ojn8XhVaf7PCdEpxh56nZ/iIHwQ==
Received: from [192.168.1.3] (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-11 (Postfix) with ESMTPSA id
 C1415180011B
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 05:18:40 +0000 (UTC)
Message-ID: <4cab865f-f9aa-4add-8c1c-08a9048041d0@mac.com>
Date: Mon, 18 May 2026 17:18:38 +1200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: GLYPH: TLB miss handlers, virtualization, and modes
From: Michael Clark <michaeljclark@mac.com>
To: qemu-devel <qemu-devel@nongnu.org>
References: <2143170d-8998-4812-9204-57febae9d755@mac.com>
Content-Language: en-US
In-Reply-To: <2143170d-8998-4812-9204-57febae9d755@mac.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: bzKZczZTUhHJTdokM5tJXxkTiwZEIjlg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDA0OCBTYWx0ZWRfXx86hFmrJG2fJ
 Ne/3+JLT8qTuIsMn022vptKefMttShu74qWW+Q8ZJ/sASymV44EzM80eETcOKDSN294sFx9uW8R
 7DtBSCAksC6Fv+MhtNIAHuSgCkhKjtB7n1ehkgp1fDb38J5P8QiHMCSlT6er8vYiqZVsX1vkxPw
 7WbmfRlNNt8NNZEq+WRbYiJ097gC9b4GhQUVVXshZtSsiyDS8PhgvMvAhhPk/iCoecfBdzZ1BkX
 AsLU07pDm7w5BkAq/Fw2ojwwNAgyY0+h5FvhgjLqSFzHu+uI5UJIiGxZlgvcnCK9XCKa5N5ly9A
 0NpdOyRMsGFW8i99qbhdjyZYqPeT5MpiNLGpFr0hT2OYLGrxRIxEwQiSr1TVwo=
X-Proofpoint-GUID: bzKZczZTUhHJTdokM5tJXxkTiwZEIjlg
X-Authority-Info-Out: v=2.4 cv=NcHrFmD4 c=1 sm=1 tr=0 ts=6a0aa131
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=x7bEGLp0ZPQA:10 a=u0hES8UrWMkA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gfWoCXCNgtdp1CFxvS4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
Received-SPF: pass client-ip=57.103.90.222; envelope-from=michaeljclark@mac.com;
 helo=outbound.ci.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 5/18/26 14:42, Michael Clark wrote:
> “This maps onto VMX non-root operation with EPT/NPT second-level 
> translation and VPID-tagged TLB behavior, but generalizes the refill 
> path into an architecturally visible per-domain handler mechanism.”

except we wrote the spec in English. that's some AI-generated nonsense.

~mc

