Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33BE4C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 22:29:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxBG7-0000GE-0Q; Thu, 20 Aug 2026 18:29:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wxBG5-0000Fp-I9
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 18:29:13 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wxBG4-0004DD-38
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 18:29:13 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67KK8SGJ4032343
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 22:29:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XpHC1BZeGxeFF9YH697vM6iZjhKAVmVy/IAiny80ZYA=; b=cQa4X2fzbQvuIdXi
 yDsZYlZPXleG4SwNlEz0nl/Ymi/vEc+Gr95XpjWYi4JBM2ypVLmQ6bt2d1XZf3sq
 J4hCSLLQHyTZgM0cEaCgQdy/Nhz86kF6+hEMBq0WCheJDDUhEoCb/U76jVXoMePW
 BnRfzme7EzghXRT9nGhAAupoSPqLQFPXXrx6EH5vIcqPYvmXDEGxinBxGWhrTxTj
 VxZUQq36QXBRa5utpotZC1ndOPpe8j7TiJByQt69EFzFhNom+OproAz8J1GMJL3w
 6pKjrSj7CUTLDOIuVDACYCgByim/HRCgsqxpz+LrCIf1h+PrPEeZv1j/6/QHyGJh
 38wzXw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5xbvbg8m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 22:29:10 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38dde0df80bso430804a91.3
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 15:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787264950; x=1787869750; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=XpHC1BZeGxeFF9YH697vM6iZjhKAVmVy/IAiny80ZYA=;
 b=N9oMYT2mUjqGqFn00vFrK9t0lCYepawJ5hB/tlBM33w2XbWpRJb1WLOgrfr6AdEmWf
 WAp5WPoJsqgMV1qvZFPpJqt8yUI6klUGIT/guys0C5+YC4Z26l74rkxEY23W3Fy0L6n/
 m90GimbwggZHxQLDRMD+KrCQ4YRi4QQl2+mfXSwU4xpVZQEJ0y//6MRMkTzdWD4itw53
 lHbaNNe9eoyLUoOnTCZxfP5hEW1GCPiucZ50LDexj852klfCAhrqQJBubtuDRgfL+qGp
 TA6wrM4QtrZ7BQTqyd7PO3iQlu08MfI3Lb1wiAEz7EGczLZ1TR8bSg6TsarW+3/j9DbQ
 lK0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787264950; x=1787869750;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XpHC1BZeGxeFF9YH697vM6iZjhKAVmVy/IAiny80ZYA=;
 b=noYyMCZ/i7om9bvPfFw6CCONrk3mWQaL4hqqlxFw7Ipa2OjDrfSYOr8BBKFTPf9B9n
 tLoyj7OCK6ViJ7fRdP7yf6FgR31oV/0j9YmKgvUwS1hMP3mZO4XvOfNG98m75VBh6lzj
 HixOm/9RIc6udEero/QA3ut5dLGe/ABpHK2H5kroxS/pN3PVo2e6Eg7BDaLN7wa52eMJ
 cjgoa4cOBjjC6CDPI8TyfK5LJqYd1E6Z0V0iPGj4ws/seSNFfB8bMeKTx1m1qIsK3lAk
 JE2BO6MwPjXPXMRHSqGbfRUZqMtuXkQc15VQ7z+YkLX8ABSwoBgnxiO3tdHgcZIxmx6B
 pFPQ==
X-Gm-Message-State: AFuF++mDakAiItfPermTDTuTwLjoPOAuj6KzoSXdzH8s85iz00bUgJTu
 PeDWOtUpTElHgFWt+j4e8PRkRhNa1QQedv/U0vmkcsAbTy0/iwbyWe29Vp2HJiPKhWbDRrcHXMP
 LxhPXxBJAVOXqcYZMw/Mu+P9I1Wx8OZKmWg4NxciXu2gS09T/SlJLaaLO7Q==
X-Gm-Gg: AR+sD121V/OW/Qt7OZ/4uU4B8wOhpHTDoCDvxQN4H1DDbI2TByQsRiy0PjfcFig8xHn
 uEy6vT47NlMsD0MRbx4HjD9T85SIDlL2f254lGaC9cjgnHmaunHJsFVdkkMxtns9FnmLy8ZZFaj
 5NwhNbi/jRGXVBL6u4pvyUC62vE9FlgE4Q0ulNgu3wJ+ffmppwnsbc4AMt02mOb6w0DPKU3DLeP
 ts0W/ba4HVv3BecWOWC70nd4bPWONG9LTRs4iRDDFyZJP4ff2q2biIKHK70MqiGccchclKC/IJf
 iGR62vOFneXtYpNO7RDUjcBPzFVZYv67xif9YPSIWSxscgYEbJJH23T5+MA/ownoSNiAEYh3fN5
 CGFMAPwX9i/fFZSAWAAiNCDdHfyGDHAe8OqCqYUnSaVchQh7rqerWoZqFA+t6aH7hOFSx
X-Received: by 2002:a17:90b:530c:b0:395:5404:95 with SMTP id
 98e67ed59e1d1-395c35516a0mr3098883a91.12.1787264949554; 
 Thu, 20 Aug 2026 15:29:09 -0700 (PDT)
X-Received: by 2002:a17:90b:530c:b0:395:5404:95 with SMTP id
 98e67ed59e1d1-395c35516a0mr3098827a91.12.1787264949126; 
 Thu, 20 Aug 2026 15:29:09 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c4b47ae8sm524884a91.13.2026.08.20.15.29.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2026 15:29:08 -0700 (PDT)
Message-ID: <4b80bd7c-1002-4ae4-a9fe-7449c0637687@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 15:29:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v5 15/28] hw/arm/smmu: Make CMDQ invalidation security-state
 aware
To: Tao Tang <tangtao1634@phytium.com.cn>, Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Mostafa Saleh <smostafa@google.com>,
 Chao Liu <chao.liu@processmission.com>,
 Jim MacArthur <jim.macarthur@linaro.org>
References: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
 <20260813162512.2807281-5-tangtao1634@phytium.com.cn>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260813162512.2807281-5-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=AMKAkK6n c=1 sm=1 tr=0 ts=6a877fb6 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=fgrLqfBXAAAA:8 a=Hmx-Tj00yXVqkUNXdAAA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=_Ge82aPy-h_wFa7gWU4u:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE2NyBTYWx0ZWRfX/JXfjxLujDK1
 D3IdWgAUW2e5Z6xL6s13y4xu6l6Pm4km93XAz8uMFQbLUWS5C+8oAaJnQ9KYSx0Ub4pq5w3GFFH
 umSaH5Nh23mJdZ/cn3/7J0/xXGtlZ+cDvb+zSwRDGdiOQsFqAOuzS8f40BOeyD+t101gvo87mpe
 9GY0gUICw9+/DYzUdK3jF1q7j6XLgps3vikGQj5eV+83CRHonIZLaNcUIttbf66hsUH0MLxlLMm
 Ue1ybAezg0Ik1kf8nqK+5xxNf+YCMWI7qeKm9tPaDeYCkc1hT32WPQrBZinLQQ8FzLtNBypfo1z
 TpCA0hnR6s3CiXRujJwVSTQU+6yvJVck7xTciSpcN/6DI+ImU6GQuk+CAGzDEBegFz5U0BrzYoU
 YrLY8XuwXlqUEhMEo7sctA/g0cWRS7wRpLwmiWS1KVIQTI5WZjQxTB9Q6G3plOA/jeTrCIQ/2XQ
 cOiJhiYaFe3geV7X8Iw==
X-Proofpoint-GUID: rPXSQk8CysQhyiqfKCvcqmk4iDClpIKH
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDE2NyBTYWx0ZWRfX7t13RoH9upxL
 XuR7MaXyHPtores+SP/zYue8jyMSTa4kHuOBPeJbQdaITRIe7sX5j66bZ0S/3+UQfKNCl1jHw52
 NOzGVgYWsOXjb5lXDxFZ0DBU7tGIdxc=
X-Proofpoint-ORIG-GUID: rPXSQk8CysQhyiqfKCvcqmk4iDClpIKH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_02,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 suspectscore=0 malwarescore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200167
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 8/13/2026 9:25 AM, Tao Tang wrote:
> Refactor CMDQ invalidation paths to carry security state and apply cache
> invalidation per sec_sid instead of globally. Add separate helpers for
> invalidating all entries and for invalidating entries belonging to one
> valid sec_sid.
> 
> In smmuv3, propagate the command queue sec_sid and command SSec through
> CFGI and TLBI handling, and gate VMID use on the stage-2 capability of
> the selected command queue, including SMMU_S_IDR1.SEL2 for a Secure
> Command queue.
> 
> Keep acceleration and IOMMU notifier propagation Non-secure-only.
> Commands targeting a programming interface other than Non-secure do not
> reach the accelerated backend or Non-secure notifiers, while Non-secure
> stage-1 CMD_TLBI_NH_ALL remains forwarded to the host.
> 
> Include the command queue SEC_SID and target SEC_SID in the relevant
> invalidation tracepoints.
> 
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> ---
>  hw/arm/smmu-common.c         | 100 ++++++++++++++++++++++++++++-
>  hw/arm/smmuv3-accel-stubs.c  |   6 +-
>  hw/arm/smmuv3-accel.c        |  30 +++++++--
>  hw/arm/smmuv3-accel.h        |   6 +-
>  hw/arm/smmuv3.c              | 121 ++++++++++++++++++++++++++---------
>  hw/arm/trace-events          |  12 ++--
>  include/hw/arm/smmu-common.h |   6 ++
>  7 files changed, 231 insertions(+), 50 deletions(-)
> 

Given this patch, would that be simpler to have multiple iotlb hashtable
per sec_sid? This way, invalidation becomes trivial.

It has been long time since last version, so I forgot if there was a
specific reason to keep a single table and add sec_sid to each entry.

Regards,
Pierrick

