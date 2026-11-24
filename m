Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17129606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 07:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YusNced5;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VpVUQKu3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVkX8-0003m4-4a; Tue, 24 Nov 2026 02:01:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVkX6-0003lQ-5P
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 02:01:40 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVkX4-0004Qy-DE
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 02:01:39 -0500
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AO2kRH92209333
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 07:01:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RcaYo+O90Z9CKcQftuzSNqYD80fT/Z9TQPNcbrX+CLk=; b=YusNced5sF1wF33M
 LnS2BAzD9FkROqe1mPK3jG1a50xfVSc7rXPktNT0dmiXHnaMqEfcCGrmWsss0ql2
 BZUTF+VKpwAOFXTJnrqTd3GuzmxuG/oZDk5vPEYOBbhExFOUG9Go0djEVGVVaTFV
 pnNXKwOqE6ID8edqp2KNReu9pAqbHDixAPJjlTsf1p4SxXAGOQbfkE4VneYV4vn6
 fQN7HtI2CPOX8Z/jPS6yT1Nbreg3VyEQV4j9gQBCgRngSWQ0nr9KEDIn8CTp9+2O
 qsHy9C2wdE+zYcZog2wv9EZQTeh9O0/HmvalL4iQ/Q+ZM5tqKc8ADE/AY/fr+C06
 36n/aQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4yy11ajw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 07:01:36 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f33438950so733819285a.1
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 23:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795503696; x=1796108496; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=RcaYo+O90Z9CKcQftuzSNqYD80fT/Z9TQPNcbrX+CLk=;
 b=VpVUQKu3GM/uXVIrP/c+Uq54U2qJrLyGgC4tBKipv2wOfZuakpaNfTCSxLhg+pWBfk
 VYEuvUSbQsVYlSo0EnADFbS0p7dGlcIRVaj1INklzPLP/v/mtEbRxJlIo/PoXGhbrFun
 bVMq45rIBElHge4uEP7ja99tYlJNmgmbM5g6SPvQ4BuraO6nnLnJzJCy/Nagr1l9wQVd
 yDiCJiqK3CC6ooTWInhv88NVzRcSTxix9d0J2vtEsjpf6A5Uba0ZfimW8kudMajEfg0a
 Axa1fMQfWrxUS+hPVBSHPXy7h94VeasIvJ4RJ0Jr6GlxSs3tJTlggJgaQtGKBkMslzf1
 4PEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795503696; x=1796108496;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RcaYo+O90Z9CKcQftuzSNqYD80fT/Z9TQPNcbrX+CLk=;
 b=FvbU0eshCs1cyp3Ohw+CSA5uuH+JjeydwejYwo1drLTI9IgP5UNwGjeiOlWpE/A+Mb
 OK5FMu1LhEkLtcEsVsNLuUe91NxT5LpSknoTt8dj3BKpCY8b5eoKDANa3dvjLDYdxjqG
 vNWaQvy3Y4SHdXFJcjsNAKIeRr5OiqGU6mLd9//jCcvlfFs03Q86at3sM+F827aiG1GA
 XxX7SSNg/4C7T6VIK6Q02aNc6TK5jZm1Pfi/jlfjmQE4UdJ85+YPas4djU4ec8cLisIn
 CI8VCkrIz++3aON3h8jOZNw6kOiUqnEnLCDN5KjhVd2InC8i7yll+9QMUp5GbXo7ssPE
 M7kA==
X-Gm-Message-State: APuU4Z+GH/r2bb7QdRXyWAHO7/PGezKJmZBlV0aomAvJz+bRq5FD9xNt
 EfUinxbfMIoBVXBkcVzl2rqw6lx2DIADO/MgXoxpvH9GCro6L0+HmdQHCqQTSU0awQpKFpAlUx2
 bKpw/brQubS4Ms/wFSCqsLikiPrlEREBKOnBX/q+ZPM3hIMUJd49jMe6m6wCl3DDI6rhu
X-Gm-Gg: AZFdTZfAXBXUTDbkQeJRN+6ZOXmJg4wwDck3dFQd7UfB6L4HEwpruWs3SXg4O1TOZQV
 REHZyZuFkn2elg/1AJtZ+Ju5aMBugtUH91doZh34YV7jdcZlDbJlspeFRFWYc89CsFh7WEZ90hD
 7E+VWmVgvyDEXudQ+3HfAf8nGVhciusHcyX3rS953eozoCJsg0oDz5uY9hnqf8nwcM6WQCYktF9
 jn/Q6r7G4jO/A3cG+oARO8x0m67TeLGK8OqdVU90jTjZe2NS3U+bv2yPLpgOuRnjB9MbN0WiRdX
 PXAUBC9zWHpHF7ZEcY8oEnAvAWcRkXRSeDOla5Fj7gjbtfcm1xBRetT3O+WiopP91HWn+y+zLqh
 zRCiYfRfUHn7Lps1rFOcnVDPvLWtm1V5L9PriamTnHaKsuzCfYPCL4phMAWtNmutQ0Ud2QWK1LP
 1QQGY47ac=
X-Received: by 2002:a05:620a:2913:b0:93e:5fff:db07 with SMTP id
 af79cd13be357-949ba9a9ae3mr2485402885a.40.1795503695838; 
 Mon, 23 Nov 2026 23:01:35 -0800 (PST)
X-Received: by 2002:a05:620a:2913:b0:93e:5fff:db07 with SMTP id
 af79cd13be357-949ba9a9ae3mr2485400585a.40.1795503695357; 
 Mon, 23 Nov 2026 23:01:35 -0800 (PST)
Received: from [192.168.69.234] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884c3063sm421649195e9.15.2026.11.23.23.01.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Nov 2026 23:01:34 -0800 (PST)
Message-ID: <c22ae2c3-10fc-4a29-890f-8762169802fe@oss.qualcomm.com>
Date: Tue, 24 Nov 2026 08:01:33 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.2 7/9] hw/sd/sdcard: Validate the migrated state
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-stable@nongnu.org
References: <20261123225349.54981-1-philmd@oss.qualcomm.com>
 <20261123225349.54981-8-philmd@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261123225349.54981-8-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: faGpeAyYjpuoCvhlUu7yFkLFvE-9msUC
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDAyNyBTYWx0ZWRfXxzJlHyw8/id/
 hYptwmmK9B7uuy4EWVjZKnQ+YPW8MhbkRjDsUz8fBl5a8FAZ1sUt2UGetQHH8Ot2WlrXF612YkW
 vsFw2q12a8dxj4tmIIv/P28nx/FXlUA=
X-Authority-Analysis: v=2.4 cv=JYspPkKV c=1 sm=1 tr=0 ts=6b053650 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=p0WdMEafAAAA:8 a=69wJf7TsAAAA:8 a=EUspDBNiAAAA:8 a=PpfnSBQOgBS-BchaTKQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDAyNyBTYWx0ZWRfXyQSU20tF3hDq
 7nHKGzHobKowd+Y//d1vFlg1hAyepyuw9iBvtWA5HOINFX9CfPhsfwlL7Qq0AuSCr+253WVNWDw
 aNXeft11+KV85CjYP7ZpVB44uz1pTmUDfEIN0AtDFyplfC8B6oU/1CIkOE8lM1pBeZz2kPpr7Z9
 F38RmJW7SWUC0Z/SWJrbZk+w6S+7GBC0+U7A9xYgwoP0MncA6cBHpZBXl8V43jVfbJ+A/t04Ssv
 1kQfGApecDn5z5zj0//qBn3SphVRhBh/Ibr0b4DnLrQIYzDw6NieGVy2J+sVkCEfHmof6n17RAz
 Ykb3X8POwGNI3S+FrqmfUpMZ8Tc3zp6KJam+8JVXPevuTgGGBsmMlpQlbnie3H2z+t/lJ26t/7h
 XflIzAjuS/tsYs28OVPljZeiCqXlF3s2YOOy/fxnovZP45JEyBdzVenE6TqntyT3/ILIhd15TTC
 Rk/WDV+f2JZDzm3HROQ==
X-Proofpoint-GUID: faGpeAyYjpuoCvhlUu7yFkLFvE-9msUC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240027
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 23/11/26 23:53, Philippe Mathieu-DaudÃ© wrote:
> Several migrated fields index the card buffers or are used without
> validation:
> 
> - data_offset and data_size index the SDState::data[] buffer in
>    sd_generic_read_data() and sd_generic_write_data(),
> - blk_len bounds the CMD18/CMD25 data loops writing to SDState::data[],
>    using the effective length from sd_blk_len() (fixed to 512 on
>    SDHC/SDXC),
> - pwd_len is the length used to access the SDState::pwd[] buffer,
> - an unknown state hits g_assert_not_reached() in sd_mode().
> 
> Check these values in a post_load_errp() handler and reject invalid
> ones. In a data state, data_offset must be below the transfer size.
> 
> Cc: qemu-stable@nongnu.org

Reported-by: phudd6 & kietvha1 from Viettel Cyber Security
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4386

> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>   hw/sd/sd.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++++-----
>   1 file changed, 49 insertions(+), 5 deletions(-)


