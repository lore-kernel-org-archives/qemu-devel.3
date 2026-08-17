Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 586DEC5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 15:45:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvzVn-0007u6-9B; Mon, 17 Aug 2026 11:44:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wvzVl-0007tl-N8; Mon, 17 Aug 2026 11:44:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wvzVj-0002di-Pz; Mon, 17 Aug 2026 11:44:29 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67HFfTRN1758456; Mon, 17 Aug 2026 15:44:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=D5NhwsuarjG11Lc+0hL9oCaZX+hNEfQl9Fxcs8Nh0AI=; b=GHf6IgDAkFjo
 +eBZJMbPBcnAq0Krxxk0AWhqgZrh9yN9Jfd3ccOiqX42tZDhx08UQAoknviO7yYU
 kyFX8a9exYacgqkVB9uqeXcnb4+AHSsvta2TZPVW9ZssRnY9tZOBHUopBU3BlSPw
 KUo8/0rJ/wqiZ5nmZP+zyDGgusSDgkHu4EYKWxZMuKHq3gRSEkaYzAMF4RrMJVdz
 jHkxESJKKYZ5W9JoVRiH8eXU/LLBuPjtQsyM1n4FH6zEwDuPADE/ax56FqJDAesc
 TgAPOV7ymDW0W3kgzztGrak71GZOWbttTKAEgXLt4R2qO8g83GX6IFvynP87EIuZ
 4ZvNsRyN9w==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fm3k2p7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Aug 2026 15:44:17 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67HFgVLf007989;
 Mon, 17 Aug 2026 15:44:16 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33xgxk36-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Aug 2026 15:44:16 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67HFiENJ25756160
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Aug 2026 15:44:15 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DC98C58059;
 Mon, 17 Aug 2026 15:44:14 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2C13D58058;
 Mon, 17 Aug 2026 15:44:14 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 17 Aug 2026 15:44:14 +0000 (GMT)
Message-ID: <e4f97605390ec0829c0ae757d6e7edabf701b78e.camel@linux.ibm.com>
Subject: Re: [PATCH 6/7] target/ppc: Reorder PPC2 flags
From: Miles Glenn <milesg@linux.ibm.com>
To: Chinmay Rath <rathc@linux.ibm.com>, Shivang Upadhyay
 <shivangu@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, npiggin@gmail.com, harshpb@linux.ibm.com,
 tommusta@gmail.com
Cc: richard.henderson@linaro.org
Date: Mon, 17 Aug 2026 10:44:13 -0500
In-Reply-To: <728087c8-b350-4993-a64a-45aba38a616f@linux.ibm.com>
References: <20260715125634.2107320-1-rathc@linux.ibm.com>
 <20260715125634.2107320-7-rathc@linux.ibm.com>
 <a2fde2b73930cfe5e555da8660598dc464c72127.camel@linux.ibm.com>
 <728087c8-b350-4993-a64a-45aba38a616f@linux.ibm.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 5nTlzrLMjC77EdVKmcJ_vG9zfYpeIy5_
X-Proofpoint-ORIG-GUID: ymYS_1PVl7BOj5fmgUMNVu7G_3lRIBeg
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDExOSBTYWx0ZWRfX1ryFeAfT/xfb
 h9uYK4fgPAaAbw5vxY1RnIFuse69eUFlcKonq3lereQt85C+aB9l9+fUDvc63G+9E+gk1sVTLaO
 1y/urXAJlOfL90vRocx9uEmtNG6oOFA=
X-Authority-Analysis: v=2.4 cv=WtQb99fv c=1 sm=1 tr=0 ts=6a832c51 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=EmAeeUEj-q4yQFINP-kA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDExOSBTYWx0ZWRfX53W6H5BUCd+x
 RLsYXf86CZRIqHKD5UcsvakhsFBYEysmGXLSSP2ZFpI4Q/AMVQ4zmAY26gSEbpQ1A0BycfdJ89j
 hcU/p+Zy9nxln287IVsC6CY0ckskmEo0S7dx+D9+issecVLHPuGmCpdI/AiSKJeqyeUNFgB5OB/
 cwCVxxABIXFnB1cx+jvd6N09tO7f3+kG9gB7uhwszcBmGWZAiVjboqsI4gHcankhVr9PucpKeOh
 xjTW3oWWIxDBk21V7QBrFHStRLiQbobcCtWC4DcNTWzVTsL58LJ44ncP0gXP/HmUOLB6orI7JY3
 a8ZsaEM449p0ll/hAZENpfmHDVASqgOWV9X6RlfSey2RYRogskZDUfItRjZhvgprtBsKmF/OnKE
 SgJYwylYDqVJilIPUTd5HVKuwAAxRfrhZSXoBaHzrhgBh5Zd+5GWdfakJ2YeKkF1oaAom+T0fFX
 3Zw276kRQ+jB2Id9udQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608170119
Received-SPF: pass client-ip=148.163.156.1; envelope-from=milesg@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-To: milesg@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

I don't have a strong opinion on this either way, but I don't think we
need a decision on this before allowing this patch set to proceed
either.  Therefore...

Reviewed-by: Glenn Miles <milesg@linux.ibm.com>

Thanks,

Glenn

On Mon, 2026-07-20 at 18:35 +0530, Chinmay Rath wrote:
> On 7/15/26 20:11, Shivang Upadhyay wrote:
> > On Wed, 2026-07-15 at 18:26 +0530, Chinmay Rath wrote:
> > > +    PPC2_BCDA_ISA206   = 0x0000000000040000ULL,
> > >       /* PPE42
> > > instructions                                                    */
> > > -    PPC2_PPE42         = 0x0000000000800000ULL,
> > > +    PPC2_PPE42         = 0x0000000000080000ULL,
> > >       /* PPE42X
> > > instructions                                                   */
> > > -    PPC2_PPE42X        = 0x0000000001000000ULL,
> > > +    PPC2_PPE42X        = 0x0000000000100000ULL,
> > >       /* PPE42XM
> > > instructions                                                  */
> > > -    PPC2_PPE42XM       = 0x0000000002000000ULL,
> > > +    PPC2_PPE42XM       = 0x0000000000200000ULL,
> > >   
> > Hi Chinmay,
> > 
> >   Would it be fine if we can do something like this instead?
> > 
> > PPC2_PPE42XM  = (1ull << 21);
> > 
> > It would be easy to see where the gaps are from next time.
> Hi Shivang,
> Thanks for the suggestion. I agree with you. Looking at the shift 
> numbers and making sure they are in consecutive incremental order would 
> make gaps less likely. However if we are to switch to this way, there 
> are about 40 such flags in cpu.h which will have to be reset in this 
> fashion. Hence should be a different patch in itself as the objective of 
> this series is different. Plus it would also bring in the risk of 
> someone shifting a bit by a value that might cause an overflow. So one 
> would have to take care of that while adding a new flag. So this way or 
> the original way, one does need to take care of couple things while 
> adding future flags.
> 
> Regards,
> Chinmay
> 
> > ~Shivang.
> > 


