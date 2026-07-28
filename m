Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A218C54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 08:09:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wocro-0004Nv-Sj; Tue, 28 Jul 2026 04:08:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wocrn-0004Ni-DN
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 04:08:47 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wocrm-0005bc-0t
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 04:08:47 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S82BCh2358535
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 08:08:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FzTWlmVKmK54jWqWrMe8m7N0mX8GCfGHzPot80cVIJk=; b=Reemu+IRqOVF/BXn
 xo8zGM9ELCK0Oc+9GgzRAZNk+00Qu9f6X+2vcA9KiM6ey90DAgIZf4oym+F9mNiq
 uKN64rAn+Uekb97VODHho0W6kvACpRCFAnw6fmdraljFg92kobmywdfSsl/EuUp1
 oAqJRATUQ/TPlC8Kuh+ecQGuVr/pVj/YU3Z4oG9J1TSS+9HeQbA1Y3Hy9yZEKUMe
 sA3har1mfeTl75S58c7jZUpL51mAeMyRYCz1uMfXws29zS91l62u12C86ctUA24H
 Ntq8EE3GknilUUM06xZ68e5UrHrK6t6495F39euo6ezUiAixS1Tdl46+IcCDcrtA
 uE1eVA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpn3y0ver-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 08:08:44 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51a8b0a08d2so33045091cf.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 01:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785226124; x=1785830924; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=FzTWlmVKmK54jWqWrMe8m7N0mX8GCfGHzPot80cVIJk=;
 b=bQ0fX2zCknXXGtd9VsdrtdRODbc2UFucQi96D8UN2EcBOdH8U1EcGiCAf9CSkFaLyE
 n9FUnN3ugOkO9UC43QppU12Ew00YRkqx/g+nmKFHESzy3AiuZr3j/Xtfz2yu/WkUGMij
 5caw+GtYl9r2TyP0SBJ/IFGXITKqp7HbhkihOpMsIONjmSFaqRqY6pJ8J4JFxoI/gOrp
 XSMT0xTNhPkv1co+sJOEOP02yFg5cCvEgXSOBfS8ThysHuKLbcoO6naNo3DnGhs8C+A5
 lzpDgNPCvwnAPJ698LhmzRJexsImDoPeoLbAdk9RaIB3xHCA3twGrnTv/g4s+PCC6OcH
 16uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785226124; x=1785830924;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FzTWlmVKmK54jWqWrMe8m7N0mX8GCfGHzPot80cVIJk=;
 b=kvAqdEOVCnCDzHT1gTZjNTD7ti0qRCWugQJiusKE3KL9bTtRh1GeTo52xw/kG3lZyh
 hKSQt7a4DfwES2Yj/DHKUGVW8MtDztiW4Bw6EPL3Ly3FxCGjtlvGRJW35lbS8/ciHGCj
 ipGsahFnqA7a3E7vg9HvkkIT2rKMwDWXrajcFvB6HdQj8lBlyNnYcG73XUNZUn1sk7er
 ZdSsNs2T8vItIMRR/qOq9eKI2H35mfSWgg78QnkVqAu77pw0qFLAxLProSgbjrhBASay
 OAXm2VHfRrscPek8BQxOP6Rz4ZvlslU/dgSpCkMS2UCDeo7xbxJwBpzSbikSJwTS+uHT
 FjQQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoO63n9PdDvBFbSXhB5vqvHJyIqHtxrsYLRVQPzidRlXszOdHRQIPkVI7TZKwROnY8kSRw1eJ2WR+48@nongnu.org
X-Gm-Message-State: AOJu0YxPr/UTmT3mhUf8DAG6hJeAdwIyx7/y+/s+vjax5O8qjXVO1svA
 7qpIKxn0s34JPOBOJptG3+f1l0MhBBWBLddTQEobp2KZcJQL7v5sifJTV6KhpxYby56O3xrB4l9
 BZp2mtj6pocVhve/4aGgG5/5alEhMYswOKWesJ6q608Iyb5o3QCJSMhszsw==
X-Gm-Gg: AR+sD11tJiCod9GCcbq7WeWQzzevxUXPqumAnvJ2jl4rEGpn9eFu1I4PP1LZmQOoBVP
 z+qUuP11mEK4TK+Fvw8sY/bQpgCbps26W9asFPs3C4ChUPbcZvA/2UktzxlqsQw6Lhv8alD3Af7
 Dmo9bIXNFrgEsCKYY+EXZDXZYt/AvIhbGQy26qBaPGxqhJM9t867LHgPzUbFfKna2a16/amYuru
 GRvRelXEJpIZoFP3mzZ8LRosuM4TwWz4/X4IO/sa8mu6nnIF49Ad49r54e5bTkDpHIH4FW6Rq8a
 cRYuuWWCAGqp36uZi7t9GbjMgOwFHZeeqjd5d/Wkg1PdDsUFBotJvO4LhlTALM4qYQIaeBKN3t7
 JNdjU6AjwJUN6JzBcJ3Rr+Rvt/eaTCQvxR9f240Z18oGt/gGRPO8=
X-Received: by 2002:ac8:5a54:0:b0:51c:4dc:287b with SMTP id
 d75a77b69052e-529d6fafab8mr11307611cf.7.1785226123699; 
 Tue, 28 Jul 2026 01:08:43 -0700 (PDT)
X-Received: by 2002:ac8:5a54:0:b0:51c:4dc:287b with SMTP id
 d75a77b69052e-529d6fafab8mr11307401cf.7.1785226123170; 
 Tue, 28 Jul 2026 01:08:43 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c63bd3sm56526595f8f.27.2026.07.28.01.08.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jul 2026 01:08:42 -0700 (PDT)
Message-ID: <6d9eb889-ef01-4ac0-8a15-8a19ac749944@oss.qualcomm.com>
Date: Tue, 28 Jul 2026 10:08:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] tests/functional/ppc: skip remote interrupts test if
 -net user not built
Content-Language: en-US
To: Shivang Upadhyay <shivangu@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: adityag@linux.ibm.com, amachhiw@linux.ibm.com, harshpb@linux.ibm.com,
 milesg@linux.ibm.com, npiggin@gmail.com, thuth@redhat.com
References: <20260728074612.42397-1-shivangu@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260728074612.42397-1-shivangu@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=fbidDUQF c=1 sm=1 tr=0 ts=6a68638c cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=-HscyIdHiU9EPQA5A3QA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA2OSBTYWx0ZWRfX7kP0StzGFr4k
 Y492PmeTepJn/00+4/hVYLglPo1xRmRW58jkLMlDWv0AXPnwX6dZZdFHosEx3giulEn7oyLFa0/
 VP38+vPyp+kEL+dRiRxbPeC2EJgfmNY=
X-Proofpoint-ORIG-GUID: 7Q0eEtaujdZLjy36DXjT3mB8zFvQroh6
X-Proofpoint-GUID: 7Q0eEtaujdZLjy36DXjT3mB8zFvQroh6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA2OSBTYWx0ZWRfXz7SMmWc5xGHT
 /HaU+B/BRcbUw47j8tjTHBD6B5kd+ZIBx9ZG7UOuLBhSjnTZITbrW+4FAEu070/rwxMvM88R4De
 6q6F3F5kI2rD3hFQSJ3TtbBIeUYcbgl6/JJoNtbTN3+8eiz8CIL0+Jp+fePQ2RSQEame9yKDi6V
 0wXuF+De7veroC74xftLSCIhdL1Mo01w7FfL7FbGzoHdVjjl9LZ3XFnM55WMZQVeeJlfhM+lrol
 TmTiir6Bqr8N3ODklYAomhY4NLpqEdtuwA1hIR/TP3PYLmmoGxzxgbD0IfpvkkmZRT17yZPiLxP
 1kh8IPtwlYr7RsSqIpYVl5RjQAPfncKyAoCHKbWk0JW9I0DuAaZS0uSd/DKqHo1WVqZ+Z9qVVt7
 1+Nmwmz18/f+NPPQVUOu3rPOHpn41qX2mxuX77hCYiP/2z9LD7kDXkaN196DxCuFiqejDfJdvSP
 fYo3ch+TLq/bZrAB6Tg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_02,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280069
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 28/7/26 09:46, Shivang Upadhyay wrote:
> While running remote interrupts test, without libslirp-devel installed,
> facing the following panic logs.
> 
>    File
>      ...
>      raise VMLaunchFailure(
>      ...<3 lines>...
>      ) from exc
>      ...
>          Output: qemu-system-ppc64: -netdev user,id=net0: network backend
> 'user' is not compiled into this binary
> 
> Adding netdev user requirement for this test.
> 
> Suggested-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> Suggested-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Fixes: 63f5ba80921 ("tests/functional: tests/functional: Add remote interrupts test for PowerNV")
> Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
> ---

Queued via hw-misc, thanks.

