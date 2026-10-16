Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CF7DCC6B2D
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 06:00:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHayU-0007mj-A3; Fri, 16 Oct 2026 01:59:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xHayS-0007mS-00
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 01:59:24 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xHayQ-0003O2-5g
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 01:59:23 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69G4fwCf3462803
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 05:59:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +e76Yleox9G0lPIEdC0QGplfhBDpOZtKzeVRV8+z5io=; b=Wn3m0VAml65s16hP
 29Cg3+oZuMtg10pt1AZMcB/hL2POZ1QrmHoUkz5lJEdhvGdsqL9IY9npO8LaTH29
 YloBGMPwbPG4NJAYNMwO+fZ5i82FDTaLLow7SQNF3TwvNOgbOV5/0H4DeIP/i+b2
 cXnDL9YZXHROSgsRGEbbjKAjCmAbyZJwXcEJIobCH9kWzlRfy9mUYFWqCFm9x1I/
 +t6eGjCynXUE7CEcznCF3+BJds5/E8EGIalM0NHPqYq9virdSPmAbIC9vz4VMR5x
 M1H8dqM0Hz3GCTiRedCfPtvy3mQMoksQApXqDRRW/Ain022CrPZtnLbtnP/BPV7z
 BWKoTw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hayu6bd17-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 05:59:20 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-9179a556c43so125560696d6.3
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 22:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792130358; x=1792735158; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+e76Yleox9G0lPIEdC0QGplfhBDpOZtKzeVRV8+z5io=;
 b=Sa9FeL9Fgv1oBLZYK9GfWBYaqOrOH1b3krhapXTjrlpe1uYqRoRj33kx8qBEubaBA5
 9yZ1Aoqa2KJqUNqXIhaXrWcN7y8NAZdQsQ3hPTZtxLdRNo0MwQhSIH2AW8lS+PVPeNX+
 Sl9l/7/9tAYj3dbOuPIMrQhTPP1Qp5qUzrtt9ZjPbRTIccDeJB2ihVSeBX4enuRnproI
 NvcBuLG7YSYCZyXkxANb9DVAawpeSoaQmypxWQXZKYaNZVrTGekWGOoNMocrCNGFd4ws
 i2OD24sgibe0DZmnNCB1BXM23ZlA3efAvtBF9Mre7O02IM34G2HBW0ZKqlHHyFsH7cHl
 0SrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792130358; x=1792735158;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+e76Yleox9G0lPIEdC0QGplfhBDpOZtKzeVRV8+z5io=;
 b=Ty7bn9grU4oeRIf45Qm5iVLn+PiyKGREhgfkJ/UIhArG7yoqgHbhxOoNSZ7F9dfH3h
 rDgusbcMLhCof5Z7crI5/2P49OYybxokshdGQsjuBKiyjgz+Y0/Cr7bOpyxF3iTkc6aX
 hYd8FZ9zQZ9W/jMjCo6sWXXOLfuLb4RZH+iNnD2rzJtEftkmcZB1sXw2itiOkvYN0kR2
 oatY9sbVY60fkLDaQ+MZ74hy5wYcR2+O8AD/ICoM2eoLnMZlF1XibHhmuhG1P6S2YH9w
 qaXbhMY11BWLyUBiLdHDpPvW6kkrjcCkehGVdHATpFoDdXTSOPrah5ataWIJ0IYyBJ/g
 HGVg==
X-Forwarded-Encrypted: i=1;
 AKwUvBw3GV7bZl4mHeXfykF2b9197ZnyBUTQdptf9GFvmAAVYjSwHVDKuRdqN8CqxSdXIPP5Znys+6dNUef1@nongnu.org
X-Gm-Message-State: AFq9FYLmoebIM6ciS9B9Yz8btigZ3KobCmDOMLruprRaYIWICeHz4adi
 7qBg3H2QUfTBTlu0C1vbjc+BsRawkmtBjeHXbL5Xvvlpm6/Fk9m4pf55TjuC3eJSIY8TWinpStp
 zsJw8A6wNQiSSAin4yREAZ6t6kYKBR7BKGIwmzd9AMkNKpnmu83facoW7Sw==
X-Gm-Gg: AYBFou3E78gT5J2mDAAMbAW3PH1EVa8xTrRCQJ8t4YFQufvG9+J4Ur1aSsuDXSiEB3I
 y8S+2BrcL/s2rrD3yTEoUjx1wJIVWdqexhaVukAHz4nudA+LDhgP4CuUr9dBt0qMHCPrL2KejFu
 3hwcqSV9UDml8zfYrMinSD6zNAg0XJCkcA8g4NxVqum9rSTc5py1xsIFUlWzPdsSqleMRcctQCY
 mZlXG4s16yoKDByy9GSjoKNQtpClrmGNlPGxYWeOwXWHPqRIT2+QWneTLBHWLcDtGQdMhLzQxcd
 Oc9QhkX372Tdx0SaolG3xtohdRE8rqOx8XIIYIRsuXavnPaqnquqTQuEU1TlXaCqExR/AhY4CHC
 wDsbPKjZLlxEhzX6bqZwpND66NLsrnNhwZA==
X-Received: by 2002:a05:620a:6189:b0:93c:9c0b:3898 with SMTP id
 af79cd13be357-93ebd27c9ebmr3273482785a.59.1792130358402; 
 Thu, 15 Oct 2026 22:59:18 -0700 (PDT)
X-Received: by 2002:a05:620a:6189:b0:93c:9c0b:3898 with SMTP id
 af79cd13be357-93ebd27c9ebmr3273481385a.59.1792130357943; 
 Thu, 15 Oct 2026 22:59:17 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1c1eb3907sm100995715e9.7.2026.10.15.22.59.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2026 22:59:14 -0700 (PDT)
Message-ID: <5aa90efa-5bbd-47b2-86d8-8e1552161668@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 07:59:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/19] multi-target: remove dump functions duplication
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 anjo@rev.ng, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20261015213236.157767-1-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261015213236.157767-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 8NE43F41ND87jm3CucdHkHGIbn6e4n_H
X-Authority-Analysis: v=2.4 cv=ff04WEQF c=1 sm=1 tr=0 ts=6ad1bd38 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=XYum2sjXKVIBjc-thtAA:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: 8NE43F41ND87jm3CucdHkHGIbn6e4n_H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDAyMyBTYWx0ZWRfX81yAPENgUgtR
 O60H0CyQoWbXop017KtIH1XTpIVKCUhYdfWil1DktV/rtSx3fMCQX0HxvJk22dM9El3yv7TdQde
 zFVD+zLDJITJPH398qHAZeqJHlOlpkpbgGS7AmC2Xzpi/uC/j+mRx7Mf66zOZB5Wwcmhz7500fw
 yjMEq2zGv4vtDaM7XnAVWlBgGtlkOZ/uABMBGeOWgRtmaGR7synUbdUbSoqnO1YU4eoW9Rp+Jnc
 k9CDzH6Cj67QVZCZc6063u+bBUw1A6oLE5OwIQCUKKcOrPlVlnpxePm125VPt9oyjikLgGqBM4J
 /ZjUsX905PKqT6if9n/TIcwhmtKT7UoE8MKBVEC/oASeWKq8VEmPybTW28m9CgEFQUPrjoT56EZ
 oqvB2SHme3mxVi7j1hIFA8aQXrdgahj4mPJc2UOpi+Zyc6JPimk2Wlj6//pK4BBO6Il1wmqQC0K
 Yy8gjtKvCRhwwlNWg8Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDAyMyBTYWx0ZWRfX8T7hOsoR0lkd
 NARnFxQOYXLAVfmgDnkqMt2xKXFJ0oyB58VNdEA5EuFOYAU3KXl0rjkrrM+NsylUONYa8XHL7tu
 7ofQU1BaEr+uqWvgFtJ31vAqNyvDpf8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 spamscore=0
 phishscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160023
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

On 15/10/26 23:32, Pierrick Bouvier wrote:
> This series removes duplication of cpu_get_note_size and cpu_get_dump_info per
> target. For this, we define a new set of Dump operations for a given cpu, and
> implement it per target.
> 
> Existing implementations were using first_cpu, which is what we continue to do.
> When we'll work on heterogeneous later, we can revisit this to either forbid a
> dump, or perform a dump for each target active.

Make sense but this must be documented, in the code, and commits 
description.

Maybe we can self-document adding '#define qemu_heterogeneous() false'
in a core header and asserting !qemu_heterogeneous() in the dump API?

