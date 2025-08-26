Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AAE6CA0FED
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 19:19:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqzBB-00026x-2L; Tue, 26 Aug 2025 15:18:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1uqzB2-00026C-7j
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 15:17:54 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1uqzAv-0004a0-I2
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 15:17:51 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QGCm3Y003241
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 19:17:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7swY28jw2RQgbIrt35Jlq3opAYlGUCcoK9gtFqcVt2Y=; b=KS+5s9gS1l4Ay3Yv
 LfokFtaLVGKkJAoxneLoLFZ8bnJBDcbx/N3QVavpy/caJ9wxNCkzK1hiIJwQ87oS
 5buwYrA8LqjKj5mHL83TDSYVE40Ycii73wCiOWcd1b/R7qJ2EWX1ldnB2EqxCVZb
 WfXVu9DqZwJ86Gm2p6rrArwwCu5pOd8Az6apQhzsgkboFHMA0oqcbYzuNEGKN0Hj
 UuJpwIipsXYbRf2lzSLD/8VU3f7oMB+DjaqhKK2bk+HYg/pj4r7MeXLDhtFExjhs
 Qp7QaFItx5L+qRx7JUVBOSHDPcFC50W51xFEg6DvcYZSheZZ/hlzEJyNPmeR4siP
 xcrikQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5we1xy8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 19:17:35 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-325ce1082bcso2735748a91.0
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 12:17:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756235854; x=1756840654;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7swY28jw2RQgbIrt35Jlq3opAYlGUCcoK9gtFqcVt2Y=;
 b=OXbHxIWy2IED2v4ZoycSMozBfMtNlK4mpMU0W3f7GyvtyqsWSEp4Z2LXy6xfAhYD8j
 YrfRAZt5Xul+61MlwJnGRwgLvz+cfFtXrPaQyCt29MO729HAJoZpooDWDG2bDxsr/I9D
 Bhedr8wXBQ/qV8tss4nKSfFIATZp6Ai0HgcH4HOIRe8+ZrjyDE42T0lHuGOI4LMYN8cW
 0WByDXlbq0fQE5CPDHvpPFHcl4ISuUR6WQLQ6EPWeCCRTejHAJmeI1sYzCVrYGzUjQLI
 yA58VgJ5fWayGRCcewGDGStA/TjdXQ0HSiuYwv/RgnYx4LmC0ufs60BX8L/G0unKIe2M
 OtWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsWAx5XjL7dk74WclZW19v/p92CCEVgr4eQujOHLa/MDb8QMVbZKWUfCwZp0MgQmeruN7BQsKS6zfU@nongnu.org
X-Gm-Message-State: AOJu0YwhKTUjTmt5hNZjRO0dmZeJdk55wku/THAdMCQZFEsnX5T2/7cl
 tYcP1lcGBf9fita0sv6XXokfqgr0uUTjNqVP0FfTS+Ee8+SPsExl7KT2JN0cdookxWKTQmyBULb
 +Mj235aYPsCZvWnG4TsWuY7s1C3YSc5ZzHJZpXNWvINHZTOMZZuEDmSEgtw==
X-Gm-Gg: ASbGnctdWPNLqr4m6sHfQMDoNM3/5ZmZ7pmolMrsGzXic/cdvX5LHUR2BS4BJG6cLvU
 sCi2Hu0kBX6NFtYQ9cmnlpUTBRigmd5nEgUCFMIf9N4PtU4URpoIlZcpZHoDK1mQAEfW81X5u7x
 oyLogEhTEvFR2H2jXu0UNYDjKhNObkjnvjpo+EiuIS5Wq1JbsW5NE47DMAigqo8bWB1c19ivs16
 Rjd4R5gBVPNULv52oaAIsGN1J/Re9C/ytfbbVo3K64VLizySc4YSb6bEH4lzCnzhhvD2snnSNbD
 i51vpzHQWZBFMWp/kb+vfJW4P4b8ODDN4QrznI3KgyYDZTl7X5148hNmlCObdLGUR5lu38BMv7s
 8zPdActjF2yC+rJTH74sKAolxMOI=
X-Received: by 2002:a17:90b:1d92:b0:324:f6f8:7701 with SMTP id
 98e67ed59e1d1-32515e225a5mr23088181a91.4.1756235854410; 
 Tue, 26 Aug 2025 12:17:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH65vNhEr0aU8t7xd34vifYN83Xj5b+Ld7r8TPMP5JMTqX0nXvlRpRINZSh8IVJrX7XunsVFA==
X-Received: by 2002:a17:90b:1d92:b0:324:f6f8:7701 with SMTP id
 98e67ed59e1d1-32515e225a5mr23088153a91.4.1756235853995; 
 Tue, 26 Aug 2025 12:17:33 -0700 (PDT)
Received: from [10.222.168.90] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b4b77dc7614sm6138999a12.8.2025.08.26.12.17.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Aug 2025 12:17:33 -0700 (PDT)
Message-ID: <f920ea53-c75f-4a45-9e30-e49af3c7bd44@oss.qualcomm.com>
Date: Tue, 26 Aug 2025 14:17:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: PGP keysigning at KVM Forum 2025
To: Andrea Bolognani <abologna@redhat.com>, qemu-devel@nongnu.org
References: <CABJz62PiQ9ipaJqr+X6AQvTJWZdAug5--4LOXa0i95DZkorNHw@mail.gmail.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <CABJz62PiQ9ipaJqr+X6AQvTJWZdAug5--4LOXa0i95DZkorNHw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: mLdZ-95btdbYejTO2OW23ZpxWHHR4_n4
X-Proofpoint-ORIG-GUID: mLdZ-95btdbYejTO2OW23ZpxWHHR4_n4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfXyzCcdIThC+27
 oKEFU/WK5EuhRKNETjMvGWALlUT0yRlPHningEbOm1Raae7lOqGmQFjJic5Cap7a4VgFUVJF9dP
 nmZNm5BTAwGSzfWgZE8Po5d8e/ExRXdDH0jzqXR9og8H/AJLY9JxJiR3R9i4gOTGWgtnVFxfaQ4
 oWuIlXZQfRYtMI7KCNo3udAqd70bp2ZH7BfiHy/HOq3x5nwV8YrP1VqKr44W5dc4H/EdUeZU0S9
 lgZSRr2cXIlGBGCAL9tMcVyYEpbM9woiYOXeOCGArlD0k2RrCfnz3OGWCatDsJU0T+hciFHPVxd
 Ibdgvx6BhrhPdEUs/d+WZUo+fXXdZJKivtVnYrhIqH1s122m7Qinf7ipu7oOfXBUNuVa6qssYfv
 WPPNp6T6
X-Authority-Analysis: v=2.4 cv=BJazrEQG c=1 sm=1 tr=0 ts=68ae084f cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=ypayWs6VMDRET1k-uXoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508230033
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 8/25/2025 7:17 AM, Andrea Bolognani wrote:
> Hi all,
>
> last year in Brno, a handful of people had decent luck gathering PGP
> signatures by performing impromptu verification during casual hallway
> chats.
>
> Of course that was only possible because both parties had come to the
> conference prepared, specifically carrying with them printouts of
> their key's information in addition to their government IDs.
>
> I suggest that we encourage more of that at this year's conference.
>
> If you are attending KVM Forum and are interested in strenghtening
> the PGP web of trust, prepare little paper slips with your key's
> details on them ahead of time and bring them to the conference; then,

Great suggestion, thanks.

Specifically what information should be on the slips?  uids, 
fingerprint, and ... anything else?

Is there a quick command to maybe dump gpg output to a pdf with N copies 
of this info on a page?


> while you're chatting with another attendee, ask whether they'd be
> interested in exchanging signatures.
>
> Please speak up if you think there's any reason to discourage this
> practice or to avoid encouraging it.
>
> Happy signing :)
>

