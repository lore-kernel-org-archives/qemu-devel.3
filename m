Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63E71C531C9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 17:17:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnJWC-0004GX-Ce; Fri, 24 Jul 2026 13:17:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wnJWA-0004GO-KX
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 13:17:03 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wnJW8-00025i-LL
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 13:17:02 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66OGrjjb3629860
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 17:16:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 A4/0LQCrrnScegq1bSGnI1jnOCCPHUz3KO02VAppmHg=; b=Pd/9d2OyAOc5NaRi
 EMvDfyZMZ58L/R6ewdIhDc94TzgR4KIVlZBPve6SZTmXFzSebnjIDebm/QwZfyBU
 2qHHKEuh2wiLswqUiwdg5+SMXa7hMhfwmKiY4YzhPyqAqj+SGBC0UkJ8uag1a+dW
 37bHTPE+Mz2fMAT/eR+nKJDxV+ib9wXwABxpOwkhF94AxiH6eY8aH/1XmE/XTwwc
 1IHx39EijWFK3ZtgGMnrlD/MBYLF2vuYwH3VLxTz42ThHrx11OlUvFgf+WQluAOD
 Rjjhx10b/99d4LRn7zFkFN0BELaIJrifRMfw1hAjmg2qPCf75UMNVze+lRA8Bxjr
 /Bk8og==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fm5yahjjg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 17:16:54 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3811279d51aso1018969a91.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 10:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784913414; x=1785518214; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=A4/0LQCrrnScegq1bSGnI1jnOCCPHUz3KO02VAppmHg=;
 b=km38weyjFv5V2+j5gI5i3RJiUvUYsVHuqdZFQhBpzAt/ypcslyf05M0lgJStjsrbH5
 M6/b1eVJm6mkg08e/cZhoR/3/IUX/xs9iOzRYayZSrRORbTOPER+Kg/OVliO3HGn6mLK
 BfQB0GZuDzkdGv5V9Bex7UcXoze0+GDRuELpf659b7Zax68tSVzK5WYNU9YPZC4VLNsx
 +i4qCleSCt6tqoVIS+NpmPhRNMW2oNcdAMOEiOpdmoZ5E5nT/yx2q1MaupEDK/pPiGgq
 Nhx08IrrPNv/t0NrK7lNzNWIO9cijTTk3eXl4j2Rmm6BJ4a1TqsozjERon/u5Re7x1vH
 FgFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784913414; x=1785518214;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=A4/0LQCrrnScegq1bSGnI1jnOCCPHUz3KO02VAppmHg=;
 b=sbntHAI3jIy8rSt0BHYg7R0CoLm7Zo21Zu2S2HkSVEWpOnyXPlfoCh5yBJ3yt7iwpU
 6Dhh9zq7tMa5RBceBZYXILGBTX0dQ3y6sjPceJg0jv6I9+rpJOXdJzMGE4/7HjrxlDCr
 6R+Msm8dqucpxBvJ1BP9o8C4KKhuTuIf6zr3ddqqM/+S3qwa3mfOnVJ4FoDsYkpKwnKZ
 a+H23UWjwVxmuHTjxJbNNgyOcrYnZ+PA1sWjwGRaW4NlBrxlSsXFgSii7bMFrP/GGQ0m
 Z/wzl9Mu+++Ujxaq9j1a8mHePUbQktWk7uGJhx4Ncm0xVJYFHqOKU2Gx7w5y61Y64ZlZ
 OYtA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp/QyFYyLJ9xi5EU+2aFrpBgBrPiqozI9l67GskmW3KmEL+hEZez0PfNPdrM3l43kjxfCrYDKyk+AYp@nongnu.org
X-Gm-Message-State: AOJu0YwL9JZfb8o7ExLwosAaQDWZ/3Zy3BPVAWBfkEqwGi8926HHFQQt
 Qy7mVkL0mYfjheia4WgG4jxbg6+ugi410HNKpySNQVxVu+a+6cwROOL9DGuKbobjcO/WwHuyQb7
 iz15EVAhNs8nQ6Qc6btIDXgT98dekTriHky7PAGmwm5+8hVfG4gBFLoM6qA==
X-Gm-Gg: AR+sD13UNrVP98rgfhBNQFnWXg4aDUw8oZy2lsDcFbqGeYJ0PXYuyWDCtEDPUuDbOE8
 Z7O499FZjAvlXyrf/U6Ifr658YrzOkKA6xuZQgVfiqgZMIxLZIoddfSvu4PdeDCi+fQGo6fK/MH
 nz+LX1LJ131bnR43loRUNszFvGbgKSQYXi+gUGxX0Y5nWUeUcVgZtqtAw/XshxcngTB7g/8Q9sb
 SI6miTUtSOSwllaIAwkuW+zCko+3IfBQzOWua7Dv1Xh0L1ehJN82FAidgXuPDbGlqxT1u1DNZrk
 SzzTlx9CU+ARXSQN6YlAM1D/wBMPSS8NQGC/XPt3At64oCL2dhnz7khYpan9aERdFL8VnqgKrVe
 84Of36/VbcPR0cUkrVb2o3H/8bYBL8n9wkECJ6neDGrR0F8Ttqkn1m+m5NJfpEAScww49
X-Received: by 2002:a17:90b:3b4a:b0:38e:6c37:d95a with SMTP id
 98e67ed59e1d1-38ec65ae446mr7647822a91.19.1784913413190; 
 Fri, 24 Jul 2026 10:16:53 -0700 (PDT)
X-Received: by 2002:a17:90b:3b4a:b0:38e:6c37:d95a with SMTP id
 98e67ed59e1d1-38ec65ae446mr7647778a91.19.1784913412724; 
 Fri, 24 Jul 2026 10:16:52 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13d13003f12sm47047282c88.2.2026.07.24.10.16.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jul 2026 10:16:52 -0700 (PDT)
Message-ID: <4eb77a14-081d-420f-86d1-b58f129024bc@oss.qualcomm.com>
Date: Fri, 24 Jul 2026 10:16:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: fix incorrect msg_l[sr]pid members of
 target_msqid_ds
To: Leo <leo@managarm.org>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>
References: <20260724160105.3787888-1-leo@managarm.org>
 <9c278046-3b5a-4d0b-ac55-76a304f1109a@oss.qualcomm.com>
 <756408ef-e40b-4f35-9f78-ccec5d3e6e1b@managarm.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <756408ef-e40b-4f35-9f78-ccec5d3e6e1b@managarm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDE1NSBTYWx0ZWRfX+VBTgEYQ7vh2
 TEdAwaX6xSlVY7K2cXTAHq6/eDnAakIbMdFERWsQr2FyUo4cFeOqX4afr/lePco7dYtcv77+uQs
 OeLyTAfBi37JNcSRm/EyUsyOcZMGnAY=
X-Authority-Analysis: v=2.4 cv=Rtz16imK c=1 sm=1 tr=0 ts=6a639e06 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=HVt22YD-8nlRTVKFy88A:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: -HtvfoWxrJcZsQ2GF1OIMnqeZKqkcm1S
X-Proofpoint-ORIG-GUID: -HtvfoWxrJcZsQ2GF1OIMnqeZKqkcm1S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDE1NSBTYWx0ZWRfX1CpnuoO3giWZ
 UwCoe3t6TefuY/tivkbbFQQhoGdKZMOHdGj2DSmq+Xd86zL2B6/kGmSc1zGYSFd/hKeurVl8r9o
 GO13LDvoz24Hkl2T7jyygsVokPQC0S5gtw5lRdilqbQwVx/C4jXsuNfE9fepxBYD+N6QPX1EsUY
 j4IDU1iZBeaINSwV30ZC1lpxg2CJRqL6mRvyskn0L4dyh8Q7BYnbQwZnmJiPH8NWqOOxlxRcNRU
 0bEsVrqdg4d7FGlI0INR92tkY4KT6Ph2s3XSYPES0onrzObZc3xvC67zgtxdl/Uq6vDMaa9qwaK
 ONYPqtTAHIEheAkerASX1j1EHtxDjFPHcJ9Bi5XT6FMhjM2NXfIUJtPx8rCXXneppiLHvyN4d+6
 FKmNK955QhNGOQwkA+OFw6z9GCX+bcY0+PTXgxLwvS3rnTxsMU/SpunJEbCYHuP/up5eU3JgZW9
 RK1NElcxQ1VaevkdOaQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 malwarescore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607240155
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

On 7/24/2026 10:13 AM, Leo via qemu development wrote:
> Hi,
> 
>> The change looks correct in itself.
>> Did it expose a bug, or did you found this reviewing original commit?
> I noticed this when the 'msg_lrpid' member was unexpectedly zero after a
> msgctl(IPC_STAT) call, and printing the 'struct msqid_ds' in question with gdb
> revealed that the expected value was not in 'msg_lrpid', but the unused member
> located right after. The 'Fixes' line is based purely on running git blame.
> 
> Cheers,
> Leo
> 
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Regards,
Pierrick

