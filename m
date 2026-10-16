Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AE24CCA46C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 16:28:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHkmy-0001eI-Nv; Fri, 16 Oct 2026 12:28:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHkmt-0001dr-Hi
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 12:28:07 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHkmr-0002rO-1d
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 12:28:06 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GE5mtG1450245
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 16:28:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yi/sQtShRYi7XFzaqdo+hT08AFkEUzSWa3IuVA9DuJo=; b=IrF9Lj/cMN3cG86k
 vtFWtWDyuO7hX1Lb+uQsis05djudZe3rGKZ6V5wMtJnPQ6oseA2PIAe/nv78xx81
 gy9P4XdUo2DYjPxM6os/teaH2LWh4f7ryD95tVLl74IqV+qrv1O5PBDFbzQ5W+8k
 KzwMFHarccoeQrfFTCkBxGha82TRUHButDQ3Avj9c1fAjrozRdAccAduW1yUNifI
 MfpBolzaTRoMBRvFRpN1+9ukaSySIZc7EvzCH+aRqbCKJ4K5FoYX5RENAND+x8rx
 HeE0wcLGzgoB7Pbt29mbVWd0gFWpay2iaeC8DVtVS9BUR3ey5u7PPJhAmNzIjl//
 VCsq2Q==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbhur1cjp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 16:28:02 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-33713e5e6daso54359eec.0
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 09:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792168082; x=1792772882; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=yi/sQtShRYi7XFzaqdo+hT08AFkEUzSWa3IuVA9DuJo=;
 b=InzDYS/7Bj+ppzRGLPDxeXKh1Php9voBG2UuYfn6yEMGBlvb26PO1VwtsQqppV85XB
 Qd8ONooReIz/0ydLRzBc2nIntqpBojXRt7PV8BgrdtOL0yaE3tN65/Ilz+GFU9qKXxef
 i93YC+vfZJOOfoOoQNH7aX8hKpG69QNZUFTw6O3HD6qtne3svGlQTaZzjmGtuSRrchVP
 XkoquF1FPhpFOVc2NTDg/OSmiRiIqlVFPlWCfFLOI6hV8NTfKz4O38ic9eaiLpBM2omV
 qymhZ6Vng2v4fIPvqVEJ06sqOA+y7YlYA9eL7f3GEeXPYJ7YUwf78RzXSBOUM2srBz2b
 kCsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792168082; x=1792772882;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yi/sQtShRYi7XFzaqdo+hT08AFkEUzSWa3IuVA9DuJo=;
 b=tfd0ZhX119kjmtw5wADj2OmJugEewpKz4qDhp95yX5bh3K94ez0YaiuXT0rncDZrzd
 xhqaUqDSxn2MDy8+tYLDFUAZrhdSknkunn57NJ4fb0EvLmW5RUzPMTnsc1e/DnSFWo18
 jHNWOdUCMnjJL/+dHJDqD5snOacv7vdet3Y8+Qv2rV9OG8qc1e7OHkvpVTbEjmOsQyhG
 Xhu5WFcJDKrn1ejKzlZ1KK9EVWWudduHX3sObJm6r5lMF+5hgPjH4DZ9fpQwFUZvqjrY
 cbDzXJaMKoNHSfffChbHFg1VvDSprbiv50ZDoXmcQgjDp84nlmgnzTxQQDTE6CY134Tq
 RYCg==
X-Forwarded-Encrypted: i=1;
 AKwUvBx7Yu0MEkbY84wVlAohcvD16LI+2wwgO9+01yREXvM2Idc8hg2++8Nv8GxxvLH73xJsM7rjXuM1w6bA@nongnu.org
X-Gm-Message-State: AFq9FYIgK5e8kbfzjaSwnMV8bzHGjR26Z3N26xHlhE+jkzmfJoR9P9xe
 V/IxZ1t2nu5BKZHm0Bv881cqENtlc7nsjkMVFpLHAyXDyHRIVVa/+qXBh58x91SJniMFiiov31G
 8bt3UJNuRGEUtbWFkVWlgX3seJHVUq1pzfNdoCvl2AdOFup47d7y9kLlgNg==
X-Gm-Gg: AYBFou2xJbx6EZzt045rMvbwaCzpX44lWmFwvjgIOiZwV/EYXgkgQI3Utjb0r60XEx2
 WzKt916nNVC9qMHz6vsteYtPTpAw2v0nGw0sGDNl0YVPfR65a1eK++BPuquigxzNyCPXyW5UPzl
 opiknwdcg71Wvwijk9s60bmxjv7FY7JmneRgBg4L9c2oUOZ0aRgOrAXqU5d0bSSGryW78XaauUJ
 Wt28z0r+SXU2qGhV3PYHqma3PYItdrmCMbArfnSukrLfYt9iIFLB6jVMvLXJOKhsj8bP18Qor1U
 nWklkNfHLKKupy/kL8kUq57cGo06CgcvjvzDOHVloLgPd5BAh3d6FuyQVBNQvi7PZl/ujYjRzB0
 w4YmhITMgPFcGeKU5C5XNa0PPK0icdcQEsfk/rhcWMzq7qHakMtmGchaJGCfrHYvZx1Rupg==
X-Received: by 2002:a05:7300:8284:b0:358:bbb7:88da with SMTP id
 5a478bee46e88-361a234c05emr312044eec.32.1792168081672; 
 Fri, 16 Oct 2026 09:28:01 -0700 (PDT)
X-Received: by 2002:a05:7300:8284:b0:358:bbb7:88da with SMTP id
 5a478bee46e88-361a234c05emr312014eec.32.1792168080937; 
 Fri, 16 Oct 2026 09:28:00 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-360813b6e33sm8500592eec.7.2026.10.16.09.28.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Oct 2026 09:28:00 -0700 (PDT)
Message-ID: <0d238118-f728-430b-9a28-d267a8874891@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 09:27:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/19] multi-target: remove dump functions duplication
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 anjo@rev.ng, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20261015213236.157767-1-pierrick.bouvier@oss.qualcomm.com>
 <5aa90efa-5bbd-47b2-86d8-8e1552161668@oss.qualcomm.com>
 <faa22811-7a04-4077-8e26-b89be0a0c972@oss.qualcomm.com>
 <d3d9ba30-e28e-44a4-8531-52b88a8b5943@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <d3d9ba30-e28e-44a4-8531-52b88a8b5943@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA2NSBTYWx0ZWRfX5eo+asu/hcmn
 PswniyjaT+Q4EEXBQRI4WSh42PlWOJv/EmUFJ1/+R5yyMCV46M3+nojwCUwNZ4UEOFt7PSrEgaF
 uwWej3WBoxXi2MAzamdHQ8lrJoOooRjoqtjEkCEc5obdDTTJT6KxtPP+jOWE4owGL0NzF48D2NV
 74it6fGE8X3FqfBkBYMu3tJfnApEpT1HzJDAzjndGvhBw4ZFcsvutQ0ju7A7F0rKEef7mFVBT/z
 2I5vKBEfkUNWFR8zYuxuOOpEgdlV8FxPY+u/5Zd2mnLVGd1sz/O0p0SKu7VfYZpBQiFyMwzBSag
 flK5TaUXZj/O02JcNIM+KPNYNfVF/m+TWHpRsNUujhkFfWDlwbhBC9QYmpNozz9B1LPKZHRH0eI
 /YHLz4Fh6zwGfxkH+z40bxZxq4JBBJLEXvAjcxXCDlpaC3Um5SN3zvkVLX+Svscv9/Qk9agqdvp
 8d/NJ93+0/v9yYN6DBw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA2NSBTYWx0ZWRfX2xftF/l31Q9v
 /RhemDVsAOykXsiawxyivG5QuXGbU8/+vIR+RBNETWzloTgh2/51ggptot0o/eV+ZJ0NdPxwkuH
 zBmiA+UTm+PYqsj+AUVvOnE55RXThZQ=
X-Authority-Analysis: v=2.4 cv=PqsG/AM3 c=1 sm=1 tr=0 ts=6ad25092 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=8bFHpYlWAIAEFyhNtxAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: 9uz_xMc9l6V9MpMicUjDp-ZTWaHSahAC
X-Proofpoint-GUID: 9uz_xMc9l6V9MpMicUjDp-ZTWaHSahAC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 phishscore=0 clxscore=1015 malwarescore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160065
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 10/16/2026 3:59 AM, Philippe Mathieu-Daudé wrote:
> On 16/10/26 08:42, Pierrick Bouvier wrote:
>> On 10/15/26 10:59 PM, Philippe Mathieu-Daudé wrote:
>>> On 15/10/26 23:32, Pierrick Bouvier wrote:
>>>> This series removes duplication of cpu_get_note_size and
>>>> cpu_get_dump_info per
>>>> target. For this, we define a new set of Dump operations for a given
>>>> cpu, and
>>>> implement it per target.
>>>>
>>>> Existing implementations were using first_cpu, which is what we
>>>> continue to do.
>>>> When we'll work on heterogeneous later, we can revisit this to
>>>> either forbid a
>>>> dump, or perform a dump for each target active.
>>>
>>> Make sense but this must be documented, in the code, and commits
>>> description.
>>>
>>> Maybe we can self-document adding '#define qemu_heterogeneous() false'
>>> in a core header and asserting !qemu_heterogeneous() in the dump API?
>>
>> I can add a new function target_heterogenenous in target_info, which
>> returns false for now. And add this check in the if for those dump
>> operations, saying it's not supported in this case.
>>
>> What do you think?
> 
> Yes please it is cheap and that'd make us safer IMHO.

Ok, I'll add this for v3.

Regards,
Pierrick

