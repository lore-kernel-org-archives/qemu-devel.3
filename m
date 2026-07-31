Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C371C5516D
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 17:37:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wprAP-0002Nd-NN; Fri, 31 Jul 2026 13:37:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wprAJ-0002K8-Vd
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 13:37:01 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wprAH-0006ch-6B
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 13:36:59 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66VFOiuq020669
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 17:36:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +5sqYwJDQb6FJ/HVIbjsE77H4LqPZvxjAw+03yOh2Yc=; b=YgxRb9qceAGfV4+/
 q78pkcISFM3z8UCdW6yQZqa6mResjQCuV7PYMttD/tuJ8IpnnzOLzU2ocd7Y51Ow
 uTx+ir2D1F8bmXAr7l7KrnyKxly4U/MkdUpQRC12PMe6hbjmi98Hje2DX59a+RmS
 Dlf+MsxgTe60ZnOBL5Znx4wDBk6xmHGyynPrdFzFjutRgCQjhmnP1CDN6xA+JxEX
 B6B+XDZSJbI/phAXZ8c/ytLs6TqSFfL9NZPTWG7W7byYfuwL/3tRS/x9o8jp9iEA
 MAr7zWYqaNeJeDeo2d0YycjkZ4OguIx1hq6euKEZDo9r2XkAktve5d/NDs3H4RHR
 aebM6g==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4frugh1gbj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 17:36:47 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38e7ff7b375so1375666a91.1
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 10:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785519407; x=1786124207; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+5sqYwJDQb6FJ/HVIbjsE77H4LqPZvxjAw+03yOh2Yc=;
 b=JFb7fsanx9S1HilaxRWRKIitKJwulHICnJXzKICOvxVn141HjimKiTU/uALu65ErX+
 Z3km44OFvQrjg+WBNHmBvRCq9V2o1fHvq0mNLcB1tdbto6SZcApVYxMp0FbxIVbk2ntf
 sz8Mqk3zjC34V/4E7d8TpvTLbYGk7bM6934sniX7lfwKDAkjDk1qP3t1dnO8wyhTHybT
 B4qDzHLDoKxaHAmu12ypLcKGgGRAXlktvrLj+FE4dBQ4cWkA5217TTL/ka4vFD6p53CT
 vW2dzrC3rQYhzvOINkYLIblD2RZVenOdwPndN/lpvoQy331VI7xmkM7Wum1sxX6z8VbZ
 4NKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785519407; x=1786124207;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+5sqYwJDQb6FJ/HVIbjsE77H4LqPZvxjAw+03yOh2Yc=;
 b=UMmBDEAT9X20VwLzS318Nbiv+oIIh/pe2IxMqfkQPDd7ezKZZIkQaMy6qbcxS6Gm8E
 1b4r+ybEtV7uMrCCmTMqvyXd3eY8Pbb+lgDP8+E5dyJSCYn5aMAfcaq656aV0Wa49UY3
 zBy0ZjAFLLN5G8aNloN22V0+3BxsLouUkjD+QdkYXv/y7bouRqQDQ2quPo48AmWDqHxs
 xaD5D3noE6GHSXNASPISpwjC5Vg4WNHqtNkCjeoDJZ0sGPM8H7dolHgSRL7xqScK6Fho
 eRuy9R1d7u0bdQ//HJF7xxT0oe3dlcV3Aldb9p4BJFAK8blUQmzgMYqmdrC3yqGicpaR
 KkUA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp00A0FvTXxEEUiQrpMDi8VY29ig/YBows/XI5HJDkdA7GUC2DeUv6H9o8GC/ei1hPkcN+lCDt7/voL@nongnu.org
X-Gm-Message-State: AOJu0YxAIsWyeOaDnQ3PGsje8RNMS7zArPRu5i/c5vx2D1IM/o70+Nzd
 hMqZ5OJJ5NAWNe3D770N9Fd81by8oPOrxS+pjlmmikXnMa+qhJjZZx6n821FnUzzIeSBVuhu8HV
 R+1qH4qOhQRS4xxfidVmN5J2UU8cpPkVQWw7nqug8Ci/w9Mqc7i5PY72uVU4qcVbM5w==
X-Gm-Gg: AR+sD12nli59GtmNLAFwZk1IJI47+0dhjrrDL7TRjXLkJ/UR33iub7ZuPfyKuoW/Z4J
 NrC/aP4wgK2XxcAMe7vmJJm8bG2HuNMFXadpEEvU03k8UN33HcKjSX5CVUIGy+2BOAa/COTT/qq
 sScE/dhz/PNZ3FacYG4gdgIsWXwb8YX9hJsvwAlbSdTAZTnb9wl2HMswwe38S7jWm2yX1XCV9g7
 CcSIFhmBjgHC4ofXXs4JdMFRpVaNqTGV6FWSoZJC69P+pISEog9OuNqoTZkwi6AhFY5306gLs+l
 rDkDxPxGYoiiFKpMeK7mSartVtJfbNd7zKQfU0xiAm1bDKZtm63EbZMitg3UGq4fhEa+pisHX/8
 pWtQFZZgm3xYdO5P0GXKO/sVMMQdN0Hp0ny8BDNn1upfeXEZG5EivqjbqcwgSbkl057az
X-Received: by 2002:a17:90b:5627:b0:38e:7239:b93b with SMTP id
 98e67ed59e1d1-38fbc4e3d60mr633399a91.30.1785519406923; 
 Fri, 31 Jul 2026 10:36:46 -0700 (PDT)
X-Received: by 2002:a17:90b:5627:b0:38e:7239:b93b with SMTP id
 98e67ed59e1d1-38fbc4e3d60mr633380a91.30.1785519406474; 
 Fri, 31 Jul 2026 10:36:46 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38fb2ce1778sm1049125a91.15.2026.07.31.10.36.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jul 2026 10:36:45 -0700 (PDT)
Message-ID: <9c19a49e-c386-436e-8d2f-93400f7a947f@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 10:36:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 16/18] hw/hexagon: connect qtimer device
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: philmd@oss.qualcomm.com, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 matheus.bernardino@oss.qualcomm.com
References: <20260730012824.1135905-1-brian.cain@oss.qualcomm.com>
 <20260730012824.1135905-17-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260730012824.1135905-17-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDEzNSBTYWx0ZWRfX+mtY1HH1feqN
 FQ4ZBQLrS4/a6+DrAiRZLBHrO++AAY3yzNsqxYJDyIk1osOmCPtUkP9hli8wyoaLDv3vHQi/fnS
 WqpUqmTCD0mm/1GQd6OclOLP2VHN2YmvrEEzmhBo3tNUBOooX28kcc2e/z8l/kxMyFo1TbAYcnL
 DeE55keHHiAAHAoYQNkoM61uuXHOHdPpbOGEWK6GKHj2XVZRcjKy8eOMegzEuvWA1sLbLquE+NS
 fqhfCmmDmX0VZeFkQZhEvcyGVhaOgPcqNRbaD0sMTT0cPc0ErVtnYGKQRj1LvIgojaS6TmZdTby
 cg0mpidVcXRRvalfaLE4ESRy1d9yTk5tN6R01zfyCKmNwSmNwaRbPUrMRVqdqGKqDlNG8m/SG/Q
 IGVTV44VXa/oI9673dfBQ8FB11suig55aCuzdxfYfe0JHXjqnC/eXl3n5UEYrG3drUfQ2jCFKOM
 ExaJdqXNLhrmPNzxWkQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDEzNSBTYWx0ZWRfX/x73rGazsLUJ
 x96AVnqeV7ct2/B7CbkIW07SXQ+70YjiEx18y+kC8YcbyhNXFiodUmaRQ2+8OrPtq0hQoKmzksw
 GZudM+l942F3hmd0bu1R2V+kQWP1wbA=
X-Authority-Analysis: v=2.4 cv=U+iiy+ru c=1 sm=1 tr=0 ts=6a6cdd2f cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=7iJ1-xpUv4L0vG1g6e0A:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: kJyfaJ88mZuWYIYCWyjX3bg8Tykp3RnS
X-Proofpoint-GUID: kJyfaJ88mZuWYIYCWyjX3bg8Tykp3RnS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_05,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 adultscore=0
 impostorscore=0 suspectscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310135
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

On 7/29/2026 6:28 PM, Brian Cain wrote:
> Add the QTimer to the shared hex-subsys so both machine models pick it
> up.  Map its view region, wire its interrupt lines into l2vic, and link
> it to the globalreg device backing HEX_SREG_TIMERLO/TIMERHI.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  include/hw/hexagon/hexagon.h           |  1 +
>  include/hw/hexagon/hexagon_globalreg.h |  4 ++++
>  hw/hexagon/hex-subsys.c                | 29 ++++++++++++++++++++++++++
>  hw/hexagon/hexagon_globalreg.c         | 17 +++++++++++++++
>  hw/hexagon/Kconfig                     |  1 +
>  5 files changed, 52 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

