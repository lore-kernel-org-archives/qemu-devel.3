Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36881C61DF0
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 04:50:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0tyY-00031Z-FR; Mon, 31 Aug 2026 00:50:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x0tyU-0002xM-TD
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 00:50:26 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x0tyT-0005fa-C8
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 00:50:26 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67V1bUoO2819939
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 04:50:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jk6hvnn8pUcMJgVh5sy1UCZyBn5hD4Xg9vLzBtDusEY=; b=p6EdZoTsdB+VLTe9
 QNaijOf+hwKotc+xEnFuniKzksrgYnyWL/0Z7yYJCt7x9QfMC6oWlCQ7g9Tq+qP/
 19GzVprBebmJhRIfZUpYqLszyJYHdIAQrNYyKwzKphwHTp9cFCwp5kSiUR4Azd1Y
 L/OW4kRzvOhJcOkedZVSgUEMCsOEhtgM8/Uvb3eZnBETWgp7gJR+871/wFjmGiQu
 fEzPrsOt3WvwkeuU4xiSZRamNDl/C163H+trWjpgOr2GebwUb+aeixS7055ZKcu/
 s0CsFUK750n6+kNwCGlYN3B8ZFSFxbPIiWCT1HX7p8I65DzJT4LhKX26WZeIzWTj
 /783yg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbqdfmkd2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 04:50:23 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92e5fc4c7e9so267572685a.3
 for <qemu-devel@nongnu.org>; Sun, 30 Aug 2026 21:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788151823; x=1788756623; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=jk6hvnn8pUcMJgVh5sy1UCZyBn5hD4Xg9vLzBtDusEY=;
 b=OmxaYq8HjIfSBmocAx0O6E91Pa965h26ZowhKWdBZX+cZfWUHOdtV1WmIxSha1/XV+
 lQ1qcMurN9dJn787xxUcF1+MbK2+gDudZwe2/DFU7EWMDUcn+YFMTEhfDB2d0418KaS/
 dfjG9DInjAMctOzFBEEAxJRtKRv/aAjZemIBVtcGXNGvd+hUKnUdNe7G5euzoHfBjwu0
 HqRPyjRrBkMHvTb72CWrej2ffWsQyvKGNE035n7+MzeVlZaIL/0uLeMZzxPmN0hbrkyB
 RTH2kbRIWvUpHhZzbNYr14ICwiC8ciYkLw5rIZcHUm/W0pj9aalv2tamdb4oFxqLkFQ6
 wf7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788151823; x=1788756623;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jk6hvnn8pUcMJgVh5sy1UCZyBn5hD4Xg9vLzBtDusEY=;
 b=Oezzue9uSmZP1eQgoI7LDcyxygsRhodhCQwAfJFMtEjTHoeyC1UzBiImzMMfjBb89X
 ZZR+Ibs4/a54ryD6My6S34UhogBt3qa2fl+5D4UPzknR7k1Q8gbNDVdg1PHwt2mf3vJz
 rI5W11R35bFGQh9ZCcjAsVQwhl4jUZENqiksRJKpmvORbwo1q6JJVMaNdRjAaZFlMKRm
 T2oB8BzUsopjaA9WY4BJ3fYVyGsHaDdA2GVKxy1MxJX7p61abL7dAGd2PEe8PsclwBzs
 e7JiERTNLEmvlEhWueqY4sGF6jGwkzEgBwmSHSfkSwWGzj2MBHobo2ZRKSJ+v47huIEK
 yz/A==
X-Forwarded-Encrypted: i=1;
 AHgh+RrOAHzdBx+wVxrpo/8WG7QjLA8cGy8CBo+vUksQ+j36fJSu1Ry7QQjnYdG/v2enMYCe9IhXi3wSwJQZ@nongnu.org
X-Gm-Message-State: AFuF++n4Ccthrv6mnRgIMbBMLi2s3+11AHLtMj3JQDTsYJeWEfX/3FzV
 fji+/hh2DAL/SvNgjAUBTxSjtLtrjBRJPIwPiwazsh+T75nhB8n7nL4+RLPK7VUIAfWc9GKsOiB
 Cxa6pzTGbbuL1R0BSyZgrVGZDOiD3LDtdltJDOwZmhxaOUZyhApoxaNPTng==
X-Gm-Gg: AR+sD13H/MZyMSnxKsV/eYgCqaMJtStBAzCf17/QGdq2Kj67g4nAfVnG98s9wd9CGBW
 v5AZpe8JmljtaId1eqWXeK0Ag45wy9xX0c0vxhKYqPTYbI9LpdQRZziANJ5UxPZZ6N1nL++3rNL
 KqCLlHSGGuxrJA0JUDKpKG6QQ0M3EhIB8dmlb3oIYZYxI2v6hOlpXd9verrQE1LB7T1CDwpQRJu
 jMNUaJNimQg8gzpMmo5MY1As3gm5WpDVAg5q4ZT7gv8rkDfx0GPbrRp6JBmnR8CkHM4mIxo9KkX
 FkFPdi58nyQ1k41AmEzqkzGNOTJQ96jucBlx/1+aJYvZtj+iCrskhCWjLTgtCgdk8Qq4jh4UZsm
 9uwlt2W7SowgdiN3HUzu5RDSKfv35GreCuQ==
X-Received: by 2002:a05:620a:2991:b0:939:353c:cddd with SMTP id
 af79cd13be357-939353cd093mr756745885a.9.1788151822650; 
 Sun, 30 Aug 2026 21:50:22 -0700 (PDT)
X-Received: by 2002:a05:620a:2991:b0:939:353c:cddd with SMTP id
 af79cd13be357-939353cd093mr756743085a.9.1788151822002; 
 Sun, 30 Aug 2026 21:50:22 -0700 (PDT)
Received: from [192.168.69.226] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cd53a4678sm84867415e9.13.2026.08.30.21.50.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Aug 2026 21:50:21 -0700 (PDT)
Message-ID: <a375c4de-7716-4b98-b5bf-f2b35cc63851@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 06:50:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/16] tcg: Sort all_outop[] by INDEX name
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mattst88@gmail.com
References: <20260828224451.1564072-1-richard.henderson@linaro.org>
 <20260828224451.1564072-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260828224451.1564072-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDAzOSBTYWx0ZWRfX+AdXliypLOKd
 UGoFprE678v3xLoE1Ul8nILC9oWKss/2qP/k5d9aDAed75mY0LddAf32/IqO5X+VVW8TzZB9jMf
 omWG/kxOoktaGLUO4tApQkV2uUCtfVUV0bCEjnDj2IzP1aQZO8s15+lTbmLjkYb8Xw8oNGUmHyM
 Bi+3bS9gf+49T0MfDC63pwjHet+hew3uGouS9f0yVJJVi75pzNflE5omAjwfKkV2DpG65zzA30i
 DFxvcXivJxlA7lvMTASWi9aQytWxHFcgqjPvym9C+J+SgrPMx3PCPoh1ynczXzp6p+Z5YNr1tE7
 HsAMAXCO87uumG5ddS9buD2EjoPsWrQIAvudwIiUrAsgYGW2rMj+iowhZkEn5j9oj+GBrcDXDx5
 Il4xxFvPu2lVu7h17XfkEKCydUO8doyIszLoE5QM4xtL3smOK4ehkfKxlkWonUN+SDtH6EXkoQd
 EJ6BT+sr5t3asi0r7lg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDAzOSBTYWx0ZWRfX0Lfej33G24K7
 uUFnMBy2jZZLBceuZ/QxdW7J3Vid4m3ebK9/POePKUfpSC/nmdCj9rUJ9Ub1OR4aHWbxiIKFiO+
 2QrJZMauLGGdp3d5tiBo6skKuetQzLg=
X-Authority-Analysis: v=2.4 cv=B7eJFutM c=1 sm=1 tr=0 ts=6a95080f cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 93k2uCmVAHpjcHXLVbg8g--X1o8X7nbg
X-Proofpoint-ORIG-GUID: 93k2uCmVAHpjcHXLVbg8g--X1o8X7nbg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_01,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310039
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 29/8/26 00:44, Richard Henderson wrote:
> Most of the opcodes were already sorted, but then there were
> a set at the bottom that were left over from the split
> between 32 and 64-bit hosts.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tcg.c | 39 +++++++++++++++++++--------------------
>   1 file changed, 19 insertions(+), 20 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

