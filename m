Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD13BCD6E45
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 20:26:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wShIr-0002Ut-Vi; Thu, 28 May 2026 16:26:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wShIN-0001o2-B6
 for qemu-devel@nongnu.org; Thu, 28 May 2026 16:25:40 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wShII-0005WA-Tc
 for qemu-devel@nongnu.org; Thu, 28 May 2026 16:25:33 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64SGUXrT3203841
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 19:07:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XRT54UXmieZNlZX6C/jf8QwOuveW6vJunnPdm/utGgA=; b=p0Om3F7Nyt0mQZci
 ZK5OCcEjZrH7WonK2Du2Uc5Di+uKWeFOJh2bjRsyWz3S+C9r+xpR3SURTUXhqrcE
 K1hNNZdQz1uC6kYerjsW6J8d3Jek5+8hQtS4l2jUSkVuxf/xOysxYeMZO4qfy+bM
 b9aegqjynvUL5fo/u2UerPzWHZUaqkYsWAuQQnxO4irLu6QFQESnwC5LiO3aB8j0
 IszDRNkCirsCS3OW0QLeu8YV2Df6qjl31rdp+dD2uhhTEGJxjROxFjppM3/w+dhR
 Ias7l4PR9VPeuRbTSWLfO1idf04QDwpaYzlIeaBa9bRLhSjYed6lR1RTvf8kxloQ
 G3JBBg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ee7ynmc5a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 19:07:53 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-304e3e3fba5so1357242eec.0
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 12:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779995272; x=1780600072; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XRT54UXmieZNlZX6C/jf8QwOuveW6vJunnPdm/utGgA=;
 b=fTpN+CBdX9tZU2T0Xc6hKHntSPrfdoqUIZE9TL3KB2dgjw2PzvDBtn4oPo8bdpO+I2
 HF42qIgBCFwwqxNTDlylKi24tHe/2UlePmOunpyxngF9AmQPDwlvpEYyiEttq7zq1lXj
 Dloe9zVER5ImEn4TqRj7gSLO3FWxdIOBlu6yQMWNguVD7NvDZk6TUDLF0y/sn3WF3rNa
 eazEzgHtYE+HGcV+JYe6FqaYrYweO9HD8mxehh6GaZe6ijqGbNSndybm3B1onWeDKyHS
 2wHrK+q0J8f9jKXJCwrtebrPITPCMjqXaMxjJJIpdEHVBqPcHZdu+uNuiaSsLxgo1EGe
 Y+nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779995272; x=1780600072;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XRT54UXmieZNlZX6C/jf8QwOuveW6vJunnPdm/utGgA=;
 b=LIYO3c0hUbjLl3LIrQaaQODVJyBv79j5zypGDqi/aqYk0akAC9sahUA/a4nitACngL
 FAJ/Dcll/cza0M1+nTWsBSONdTmPrcLBB+5vngg0kPVrB2SLpi0RvCrCRP3dBNDkxMfe
 HOshr35XwG4qEoKZ+9hsNTWrVzEWK4F3Y3/yZ8ypzeCMuElE4nnOtBT0Kfqodh+5l4OS
 4PkXmsfooQoU1swOpzNiVaQ5nuf0d8hxKKTPxEiNkOPOb2sZZx/Jw6BdXF9lsyiiAMiv
 vdeh0vIOlDNi7KNulq932VgMkVfKOFqZ4gN3RURYajb4NwTI7bU9SwwIBbwwG13DiccN
 MQoQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8MtopDP+x7nmUK3EOgy+kR1mUhfFWfZ1iB+mvk9+PcuPR36ad6OKoU3a20ZbxmDcnZo6BJ5B4an3uY@nongnu.org
X-Gm-Message-State: AOJu0YyCDWyOoOzingo4CVvCePjclt6o9zDABVU+r4jdlL6YNCSToC9E
 ohnr5EgS1M+cSeOD6BcdEReI0BFNZENO/Z3YMtQoBl1vX1LTLvgSpxuBApC0zrvS+gPjKXD53J2
 qtF8dFo99Nr42N4VivBaMUyWIVxs/HK7v4S9NXGhJvhN7pEBqdQ/KjX1bJA==
X-Gm-Gg: Acq92OF3enjDdp9XHG5Bfyeevrm1gq1owjajzD/VuTZGAEPUcaY6rnaSOugubjbYGhC
 e9rumVvac/iQwV1UpnaDvceNKpPsbFkJXgJyq/cYMJmUNaQ6BxPzC03JE2YwsOLfypD1364MdyH
 Ko5inqhQDV+Sdfevb2/qKMZx3P0/ZnBI/9QtFXaTTwjoAJ06av0N9Ot7Qy9oLfBjYI8w7sUmr3q
 4pMtredtjmp+RKKcIVffqP7AohrMf4aw1/ifbbVu77HfU2uPIoYpgEH+Pe6pT3b1RAc9yy/IWmj
 X0biNbwsdphjFNDtyHvMV61/n8ADTLp7RFXltanWTDQkZF8Io2Z8y6SRNim+4r7Ai8j4k7DTAWY
 w8f3IpNVmuzEBAev65thzSglRECILnDlHHqIMO5f0TGQXgantJimg5Tc4Fao849nLhEas3n5D2e
 XLMExAsGY7LE8mbfTQzODfKQte
X-Received: by 2002:a05:7300:2307:b0:304:705f:e4e8 with SMTP id
 5a478bee46e88-304e8cd4ff4mr157312eec.32.1779995272340; 
 Thu, 28 May 2026 12:07:52 -0700 (PDT)
X-Received: by 2002:a05:7300:2307:b0:304:705f:e4e8 with SMTP id
 5a478bee46e88-304e8cd4ff4mr157288eec.32.1779995271831; 
 Thu, 28 May 2026 12:07:51 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304e990f413sm115280eec.20.2026.05.28.12.07.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2026 12:07:51 -0700 (PDT)
Message-ID: <d502be21-6b89-4231-ac06-8e3989378dbb@oss.qualcomm.com>
Date: Thu, 28 May 2026 12:07:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] linux-user/strace: add fsmount series of syscalls
To: Xinhui Yang <cyan@cyano.uk>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Mingcong Bai <jeffbai@aosc.io>
References: <cover.1779876076.git.cyan@cyano.uk>
 <610babeb23869f75133b3a8c217915aa8781fe7d.1779876076.git.cyan@cyano.uk>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <610babeb23869f75133b3a8c217915aa8781fe7d.1779876076.git.cyan@cyano.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDE5MiBTYWx0ZWRfX3PRATszNZysH
 pGW5q+pyt42PBqrEl8qePtZtF4PNsjSgXXY/zRyFHMpaEGHWVB5idfwvygqwHXgwTbnAjWd+u3k
 6dzpsK1JXwheZMbNTscYEXpedKGOs0Vqh00q/ckKBpmPkZwSGApUFDhZs+hmLxUMnkwtTdjc6HP
 gK73OYPKxcTyPvgnWVXdNsNuYRZ/cH20kvaPFD7xAlK23ugI6zZDjfR8/OuoP0jGa7JpXB9gYl5
 O08d34w11hNKCsu/rYwdV5kj7aTe3RVSBcz+ekUcXgicVuvswoo0nRrUOqE6mz+JteKYKG01Xjx
 H1KPCX4wboq1z6IkozvYI38iiYr/cU+SV388W6n+LMY7gjp8Hoc75L8FvCD45tNqnCj7B/s+f54
 8QW8Wvsyd7JBLnXbtVYcxYHtH18bcqYijMw6FwhaMnjvqzKOr6Pe5pj1Q2XyfoeP8oV0/3YAPgY
 4+GC5fFy18H8pvl0F5A==
X-Proofpoint-ORIG-GUID: f49DjyOV1LT1wfKpvGBr_UWSHhIUhvZa
X-Proofpoint-GUID: f49DjyOV1LT1wfKpvGBr_UWSHhIUhvZa
X-Authority-Analysis: v=2.4 cv=EdL4hvmC c=1 sm=1 tr=0 ts=6a189289 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=U4RnUfbE3KfeAGObRfUA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 phishscore=0 clxscore=1015 bulkscore=0
 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280192
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 5/27/2026 3:11 AM, Xinhui Yang wrote:
> Following the addition of fsmount(2) series of syscalls in the syscall
> handler, strace support is added, with a dedicated function to print the
> parameters of fsconfig(2), which contains parameters that can be
> interpreted as multiple types.
> 
> Snippet of the strace dump when running `mount -t tmpfs tmpfs /media`:
> 
> 18 fsopen(tmpfs,1) = 3
> 18 read(3,0x407fcf1c,8191) = -1 errno=61 (No data available)
> 18 fsconfig(3,FSCONFIG_SET_STRING,"source","tmpfs",0) = 0
> 18 read(3,0x407fce3c,8191) = -1 errno=61 (No data available)
> 18 fsconfig(3,FSCONFIG_CMD_CREATE,NULL,NULL,0) = 0
> 18 read(3,0x407fce3c,8191) = -1 errno=61 (No data available)
> 18 fsmount(3,1,0) = 4
> 18 read(3,0x407fce3c,8191) = -1 errno=61 (No data available)
> 18 statx(4,"",AT_EMPTY_PATH|AT_STATX_SYNC_AS_STAT,0x1000,0x407fee98) = 0
> 18 move_mount(4,,-100,/media,4) = 0
> 18 read(3,0x407fcfcc,8191) = -1 errno=61 (No data available)
> 18 close(3) = 0
> 18 close(4) = 0
> 
> Signed-off-by: Xinhui Yang <cyan@cyano.uk>
> ---
>  linux-user/strace.c    | 105 +++++++++++++++++++++++++++++++++++++++++
>  linux-user/strace.list |  15 ++++++
>  2 files changed, 120 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

